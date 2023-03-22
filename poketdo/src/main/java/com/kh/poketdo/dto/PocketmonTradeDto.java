package com.kh.poketdo.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PocketmonTradeDto {

  private int pocketmonTradeNo;
  private int allboardNo;
  private String pocketmonTradeTitle;
  private String pocketmonTradeWriter;
  private Date pocketmonTradeWrittenTime;
  private String pocketmonTradeContent;
  private Date pocketmonTradeTradeTime;
  private int pocketmonTradeComplete;
  private int pocketmonTradeRead;
  private int pocketmonTradeReply;
  private int pocketmonTradeLike;
}
