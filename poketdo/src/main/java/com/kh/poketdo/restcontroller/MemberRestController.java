package com.kh.poketdo.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dao.MemberSealAttachmentNoDao;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberSealAttachmentNoDao memberSealAttachmentNoDao;
	
	@GetMapping("/memberId/{memberId}")
	public String findId(@PathVariable String memberId) {
		return memberDao.selectOne(memberId) == null ? "Y" : "N";
	}
	
	@GetMapping("/memberNick/{memberNick}")
	public String findNickname(@PathVariable String memberNick) {
		return memberDao.selectByNickname(memberNick) == null? "Y" : "N";
	}


	// 멤버아이디로 attachmentNo 찾기
	@GetMapping("/attachmentNo/memberId/{memberId}")
	public Integer getSealAttachmentNo(@PathVariable String memberId) {
		return memberSealAttachmentNoDao.selectOneSealAttachmentNo(memberId);
	}
	@GetMapping("/attachmentNo/memberNick/{memberNick}")
	public Integer getSealAttachmentNoByNick(@PathVariable String memberNick) {
		return memberSealAttachmentNoDao.selectOneSealAttachmentNoByNick(memberNick);
	}
	// Url
	@GetMapping("/sealUrl/memberId/{memberId}")
	public String getSealUrl(@PathVariable String memberId) {
		return memberSealAttachmentNoDao.getSealUrl(memberId);
	}
	@GetMapping("/sealUrl/memberNick/{memberNick}")
	public String getSealUrlByNick(@PathVariable String memberNick) {
		return memberSealAttachmentNoDao.getSealUrlByNick(memberNick);
	}
}
