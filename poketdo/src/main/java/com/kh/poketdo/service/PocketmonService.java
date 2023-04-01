package com.kh.poketdo.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.PocketmonDao;
import com.kh.poketdo.dao.PocketmonImageDao;
import com.kh.poketdo.dao.PocketmonJoinTypeDao;
import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dao.PocketmonWithImageDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.PocketmonDto;
import com.kh.poketdo.dto.PocketmonImageDto;
import com.kh.poketdo.dto.PocketmonJoinTypeDto;
import com.kh.poketdo.dto.PocketmonWithImageDto;
import com.kh.poketdo.vo.PocketPaginationVO;
import com.kh.poketdo.vo.PocketmonWithTypesVO;

@Service
public class PocketmonService {

	@Autowired
	private PocketmonDao pocketmonDao;
	@Autowired
	private FileUploadProperties fileUploadProperties;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private PocketmonImageDao pocketmonImageDao;
	@Autowired
	private PocketmonTypeDao pocketmonTypeDao;
	@Autowired
	private PocketmonJoinTypeDao pocketmonJoinTypeDao;
	@Autowired
	private PocketmonWithImageDao pocketmonWithImageDao;
	
	
	private File dir;
	
	@PostConstruct	//최초 1번만 실행되는 메소드
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	public void pocketmonInsert(
			@ModelAttribute PocketmonDto pocketmonDto,
			MultipartFile attach
			) throws IllegalStateException, IOException {
		//1. 포켓몬 정보 등록
		pocketmonDao.insert(pocketmonDto);
		
		//2. 첨부한 파일이 있을경우
		if(!attach.isEmpty()) {
			//2-1.첨부 파일 저장 및 등록
			int attachmentNo = attachmentDao.sequence();
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target); //저장
			
			attachmentDao.insert(AttachmentDto.builder()
										.attachmentNo(attachmentNo)
										.attachmentName(attach.getOriginalFilename())
										.attachmentType(attach.getContentType())
										.attachmentSize(attach.getSize())
									.build());
			//2-2 포켓몬정보테이블과 첨부파일 정보 연결
			pocketmonImageDao.insert(PocketmonImageDto.builder()
												.pocketNo(pocketmonDto.getPocketNo())
												.attachmentNo(attachmentNo)
											.build());
		}
	}
	
	public void pocketmonEdit(
			@ModelAttribute PocketmonDto pocketmonDto,
			MultipartFile attach,
			@RequestParam int pocketNo,
			RedirectAttributes attr
			) throws IllegalStateException, IOException {
		//1. 포켓몬 정보 수정
		pocketmonDao.edit(pocketmonDto);
		
		//2. 첨부한 파일이 있을경우
		if(!attach.isEmpty()) {
			pocketmonImageDao.imageDelete(pocketNo);
			//2-1.첨부 파일 저장 및 등록
			int attachmentNo = attachmentDao.sequence();
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target); //저장
			
			attachmentDao.insert(AttachmentDto.builder()
										.attachmentNo(attachmentNo)
										.attachmentName(attach.getOriginalFilename())
										.attachmentType(attach.getContentType())
										.attachmentSize(attach.getSize())
									.build());
			//2-2 포켓몬정보테이블과 첨부파일 정보 연결
			pocketmonImageDao.insert(PocketmonImageDto.builder()
												.pocketNo(pocketmonDto.getPocketNo())
												.attachmentNo(attachmentNo)
											.build());
		}
		attr.addAttribute("pocketNo", pocketmonDto.getPocketNo());
	}
	
	//포켓몬 전체 속성 불러오기
	public List<PocketmonWithTypesVO> pocketmonTypeSelect(
			@ModelAttribute("vo") PocketPaginationVO vo
			){
		
		// 포켓몬들이 전부 들어있는 list
	    List<PocketmonWithImageDto> list = pocketmonWithImageDao.selectList(vo);
	    
	    // 타입이 포함된 pocketmonWithType들이 담긴 list(model에 첨부)
	    List<PocketmonWithTypesVO> list3 = new ArrayList<>();
	    
	    for (PocketmonWithImageDto dto : list) {
	      // 해당 포켓몬이 가진 속성들을 저장한 속성list (정규화)
	      List<PocketmonJoinTypeDto> list2 = 
	    		  pocketmonJoinTypeDao.selectOne(dto.getPocketNo());
	      List<Integer> typeNoList = new ArrayList<>();
	      List<String> typeList = new ArrayList<>();  
	      for (PocketmonJoinTypeDto joinDto : list2) {
	        typeList.add(pocketmonTypeDao.selectOneForTypeName(joinDto.getTypeJoinNo()));
	        typeNoList.add(joinDto.getTypeJoinNo());
	      }
	      
	      //포켓몬스터 이미지 URL List
	      PocketmonWithImageDto imageDto = 
	    		  pocketmonWithImageDao.selectOne(dto.getPocketNo());
	      
	      
	      // jsp파일에 보내질 list3에 PocketmonWithTypes를 build하여 추가
	      list3.add(
	        PocketmonWithTypesVO
	          .builder()
	          .pocketNo(dto.getPocketNo())
	          .pocketName(dto.getPocketName())
	          .pocketBaseHp(dto.getPocketBaseHp())
	          .pocketBaseAtk(dto.getPocketBaseAtk())
	          .pocketBaseDef(dto.getPocketBaseDef())
	          .pocketBaseSpd(dto.getPocketBaseSpd())
	          .pocketBaseSatk(dto.getPocketBaseSatk())
	          .pocketBaseSdef(dto.getPocketBaseSdef())
	          .pocketEffortHp(dto.getPocketEffortHp())
	          .pocketEffortAtk(dto.getPocketEffortAtk())
	          .pocketEffortDef(dto.getPocketEffortDef())
	          .pocketEffortSpd(dto.getPocketEffortSpd())
	          .pocketEffortSatk(dto.getPocketEffortSatk())
	          .pocketEffortSdef(dto.getPocketEffortSdef())
	          .pocketTypes(typeList)
	          .pocketTypeNoes(typeNoList)
	          .imageURL(imageDto.getImageURL())
	          .build()
	      );
	    }
	    return list3;
	}
	
	//포켓몬 속성 불러오기
		public List<PocketmonWithTypesVO> pocketmonTypeSelect(int pocketNo){
			
			// 포켓몬들이 전부 들어있는 list
		    List<PocketmonWithImageDto> list = pocketmonWithImageDao.selectOneWithType(pocketNo);
		    
		    // 타입이 포함된 pocketmonWithType들이 담긴 list(model에 첨부)
		    List<PocketmonWithTypesVO> list3 = new ArrayList<>();
		 
		    for (PocketmonWithImageDto dto : list) {
		      // 해당 포켓몬이 가진 속성들을 저장한 속성list (정규화)
		      List<PocketmonJoinTypeDto> list2 = 
		    		  pocketmonJoinTypeDao.selectOne(dto.getPocketNo());
		      List<Integer> typeNoList = new ArrayList<>();
		      List<String> typeList = new ArrayList<>();  
		      for (PocketmonJoinTypeDto joinDto : list2) {
		        typeList.add(pocketmonTypeDao.selectOneForTypeName(joinDto.getTypeJoinNo()));
		        typeNoList.add(joinDto.getTypeJoinNo());
		      }
		      
		      //포켓몬스터 이미지 URL List
		      PocketmonWithImageDto imageDto = 
		    		  pocketmonWithImageDao.selectOne(dto.getPocketNo());
		      
		      
		      // jsp파일에 보내질 list3에 PocketmonWithTypes를 build하여 추가
		      list3.add(
		        PocketmonWithTypesVO
		          .builder()
		          .pocketNo(dto.getPocketNo())
		          .pocketName(dto.getPocketName())
		          .pocketBaseHp(dto.getPocketBaseHp())
		          .pocketBaseAtk(dto.getPocketBaseAtk())
		          .pocketBaseDef(dto.getPocketBaseDef())
		          .pocketBaseSpd(dto.getPocketBaseSpd())
		          .pocketBaseSatk(dto.getPocketBaseSatk())
		          .pocketBaseSdef(dto.getPocketBaseSdef())
		          .pocketEffortHp(dto.getPocketEffortHp())
		          .pocketEffortAtk(dto.getPocketEffortAtk())
		          .pocketEffortDef(dto.getPocketEffortDef())
		          .pocketEffortSpd(dto.getPocketEffortSpd())
		          .pocketEffortSatk(dto.getPocketEffortSatk())
		          .pocketEffortSdef(dto.getPocketEffortSdef())
		          .pocketTypes(typeList)
		          .pocketTypeNoes(typeNoList)
		          .imageURL(imageDto.getImageURL())
		          .build()
		      );
		    }
		    
		    return list3;
		}
	
	public List<String> pocketmonTypeSelectOne(@RequestParam int pocketNo){
			
		List<PocketmonJoinTypeDto> list2 = 
	    		  pocketmonJoinTypeDao.selectOne(pocketNo);

	      List<String> typeList = new ArrayList<>();  
	      for (PocketmonJoinTypeDto joinDto : list2) {
	        typeList.add(pocketmonTypeDao.selectOneForTypeName(joinDto.getTypeJoinNo()));
	        
	      }
		return typeList;
	}
	
	
}
