import java.sql.*;
import java.util.Properties;
import java.util.logging.Logger;
import java.util.logging.FileHandler;
import java.util.logging.SimpleFormatter;
import java.io.IOException;
import java.util.Date;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

class CheckWeight{

	public static void sendEmailWithAttachments(String host, String port,
			final String userName, final String password, String toAddress,
			String subject, String message, String[] attachFiles)
			throws AddressException, MessagingException {
		// sets SMTP server properties
		Properties properties = new Properties();
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", port);
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.user", userName);
		properties.put("mail.password", password);

		// creates a new session with an authenticator
		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		};
		Session session = Session.getInstance(properties, auth);

		// creates a new e-mail message
		Message msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress(userName));
		InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
		msg.setRecipients(Message.RecipientType.TO, toAddresses);
		msg.setSubject(subject);
		msg.setSentDate(new Date());

		// creates message part
		MimeBodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(message, "text/html");

		// creates multi-part
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messageBodyPart);

		// adds attachments
		if (attachFiles != null && attachFiles.length > 0) {
			for (String filePath : attachFiles) {
				MimeBodyPart attachPart = new MimeBodyPart();

				try {
					attachPart.attachFile(filePath);
				} catch (IOException ex) {
					ex.printStackTrace();
				}

				multipart.addBodyPart(attachPart);
			}
		}

		// sets the multi-part as e-mail's content
		msg.setContent(multipart);

		// sends the e-mail
		Transport.send(msg);

	}

	public static void main(String args[]){
		Logger logger = Logger.getLogger("MyLog");  
		FileHandler fh;
		SimpleFormatter formatter = new SimpleFormatter(); 

		// SMTP info
		String host = "smtp.gmail.com";
		String port = "587";
		//email and password of the sender
		String mailFrom = "watchfloorproject@gmail.com"; //abc@gmail.com	
		String password = "watchfloor@123"; //password	
		
		// message info
		String mailTo = "watchfloorproject@gmail.com";
		String subject = "ALERT, Incident Report";
		String message = "An inconsistency has been found. Please find the details attached with this email.";

		try{
			fh = new FileHandler("/home/shantanu/CheckWeight.log");  
        	logger.addHandler(fh);
        	 
        	fh.setFormatter(formatter);

        	String[] attachFiles = new String[1];
			attachFiles[0] = "/home/shantanu/CheckWeight.log";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/Watchfloor?useSSL=false", "root", "admin123");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from robort_monitoring");
			while(rs.next()){
				int weight = rs.getInt("wait_of_sample_indays");
				String user_name = rs.getString("email");
				int barcode = rs.getInt("barcode");
				if(weight == 0){
					logger.info("The sample is empty or tampered.\nUser: "+ user_name + "\nBarcode: " + barcode);
					sendEmailWithAttachments(host, port, mailFrom, password, mailTo,subject, message, attachFiles);
				}
			}

			rs.close();
			st.close();
			con.close();
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
}