package com.kh.poketdo.advice;

//401번 상황을 대체하기 위한 예외 클래스
public class RequireLoginException extends RuntimeException{
	
	//메세지 전달을 위해 생성자 생성
	public RequireLoginException(String message) {
		super(message);
	}
}
