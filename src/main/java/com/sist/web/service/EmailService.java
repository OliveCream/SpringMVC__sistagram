package com.sist.web.service;


import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.sist.web.model.Email;

@Service
public class EmailService {
	
    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

	@Autowired
	private JavaMailSender mailSender;
	
	//이메일 전송 메서드
	public void sendEmail(String userEmail) {
		
		String from = "Email@naver.com";	
		String[] to = new String[] { userEmail };
		String subject = "Sistagram 임시비밀번호";
		String content = "<html><body>"
						+ "<p style='font-size:20px;'>회원님의 임시비밀번호는 <b>[ " + getRandomPwd() + " ]</b> 입니다.</p>"
						+ "</body></html>";
		
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
	
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);	
			mailHelper.setText(content, true);
			
			mailSender.send(mail);
	
			logger.info("[EmailService] -- 메일 전송 완료!!");
		} catch (Exception e) {
			logger.error("[EmailService]메일 전송 중 오류 발생 -- ", e);
		}
	}
	
	//임시 비밀번호 생성
	public String getRandomPwd() {
		String tempPwd = "";
		
		int leng = 6;
		int idx = 0;
		
		char[] charSet = new char[] {
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
			'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
			'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
			'!','@','&','?'
		};
		
		StringBuilder randomPwd = new StringBuilder();
		
		Random random = new Random();
		
		for (int i = 0; i < leng ; i++) {
			double rd = random.nextDouble();
			idx = (int) (charSet.length * rd);
			
			randomPwd.append(charSet[idx]);
		}
		
		return randomPwd.toString();
	}
	
}
