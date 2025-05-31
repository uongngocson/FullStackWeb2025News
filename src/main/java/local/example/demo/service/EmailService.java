// Tạo EmailService.java trong services
package local.example.demo.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendInvoiceEmail(String to, String orderId, String customerName, byte[] pdfBytes)
            throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        // Set email details
        helper.setTo(to);
        helper.setSubject("Your Invoice for Order #" + orderId);
        helper.setText(
                "Dear " + customerName + ",\n\n" +
                        "Thank you for your order! Please find attached the invoice for Order #" + orderId + ".\n\n" +
                        "Best regards,\nYour Company Name",
                false);

        // Attach PDF
        helper.addAttachment("invoice_" + orderId + ".pdf", new ByteArrayResource(pdfBytes));

        // Send email
        mailSender.send(message);
    }

}