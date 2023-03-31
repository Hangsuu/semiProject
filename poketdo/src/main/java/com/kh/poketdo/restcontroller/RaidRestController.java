package com.kh.poketdo.restcontroller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.RaidDao;
import com.kh.poketdo.dao.RaidJoinDao;
import com.kh.poketdo.dto.RaidJoinDto;
import com.kh.poketdo.vo.RaidJoinVO;

@RestController
@RequestMapping("/rest/raid")
public class RaidRestController {
	@Autowired
	private RaidDao raidDao;
	@Autowired
	private RaidJoinDao raidJoinDao;
	
	@PostMapping("/join")
	public List<Integer> join(@ModelAttribute RaidJoinDto raidJoinDto){
		String memberId = raidJoinDto.getRaidJoinMember();
		String writer = raidDao.selectOne(raidJoinDto.getRaidJoinOrigin()).getRaidWriter();
		int allboardNo = raidJoinDto.getRaidJoinOrigin();
		int currentCount = raidJoinDao.count(raidJoinDto.getRaidJoinOrigin());
		//작성자가 아니고 참가신청한 적이 없으면 참가신청 등록하고 카운트 해서 확정자/신청자 배열로 전송
		if(!writer.equals(memberId) && !raidJoinDao.isJoiner(allboardNo, memberId) && currentCount<=4) {
			raidJoinDao.insert(raidJoinDto);
		}
		//아니면 신청하지 않고 확정자/신청자 배멸만 전송
		return raidJoinDao.joinerCount(allboardNo);

	}
	@GetMapping("/{allboardNo}")
	public List<RaidJoinDto> participant(@PathVariable int allboardNo){
		return raidJoinDao.selectList(allboardNo);
	}
	@GetMapping("/confirmed/{allboardNo}")
	public List<RaidJoinDto> confirmed(@PathVariable int allboardNo){
		return raidJoinDao.selectConfirmedList(allboardNo);
	}
	@GetMapping("/isjoiner/{allboardNo}")
	public RaidJoinVO isJoiner(@PathVariable int allboardNo, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		RaidJoinDto raidJoinDto = raidJoinDao.selectOne(allboardNo, memberId);
		String raidJoinContent = "";
		if(raidJoinDto!=null) raidJoinContent = raidJoinDto.getRaidJoinContent();
		boolean isConfirmed = false;
		if(raidJoinDto!=null) isConfirmed=raidJoinDao.isConfirmed(allboardNo, memberId);
		return RaidJoinVO.builder().isJoiner(raidJoinDao.isJoiner(allboardNo, memberId))
				.raidJoinContent(raidJoinContent).raidCode(raidDao.selectOne(allboardNo).getRaidCode())
				.isConfirmed(isConfirmed).build();
	}
	@DeleteMapping("/{allboardNo}")
	public List<Integer> delete(@PathVariable int allboardNo, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		raidJoinDao.delete(allboardNo, memberId);
		List<Integer> list = new ArrayList<>();
		int count = raidJoinDao.count(allboardNo);
		raidDao.confirmedCount(count, allboardNo);
		int participant = raidJoinDao.participant(allboardNo);
		list.add(count);
		list.add(participant);
		return list;
	}
	@PutMapping("/")
	public void edit(@ModelAttribute RaidJoinDto raidJoinDto, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		raidJoinDto.setRaidJoinMember(memberId);
		raidJoinDao.edit(raidJoinDto);
	}
	@PostMapping("/confirm")
	public List<Integer> confirm(@ModelAttribute RaidJoinDto raidJoinDto) {
		raidJoinDao.confirm(raidJoinDto.getRaidJoinOrigin(), raidJoinDto.getRaidJoinMember());
		return raidJoinDao.joinerCount(raidJoinDto.getRaidJoinOrigin());
	}
	@PostMapping("/refuse")
	public List<Integer> refuse(@ModelAttribute RaidJoinDto raidJoinDto) {
		raidJoinDao.delete(raidJoinDto.getRaidJoinOrigin(), raidJoinDto.getRaidJoinMember());
		return raidJoinDao.joinerCount(raidJoinDto.getRaidJoinOrigin());
	}
	@PostMapping("/ban")
	public List<Integer> ban(@ModelAttribute RaidJoinDto raidJoinDto) {
		raidJoinDao.ban(raidJoinDto.getRaidJoinOrigin(), raidJoinDto.getRaidJoinMember());
		return raidJoinDao.joinerCount(raidJoinDto.getRaidJoinOrigin());
	}
}
