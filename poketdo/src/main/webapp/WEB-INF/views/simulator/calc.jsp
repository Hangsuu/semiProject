<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
   <style>
       .personal-atk, .personal-def, .personal-spatk, .personal-spdef, .personal-spd{
           font-size:0.7em
       }
       .mt-70 {
			margin-top: 70px;
		}
   </style>
<script src="/static/js/calc.js"></script>
 </head>
 <body>
   <div class="container-900 mt-50 mb-50">
       <div class="float-box">
           <div class="row float-left">
               <h1 style="font-size:2em">능력치 계산기</h1>
               <input name="pocketmonNumber" class="form-input mt-70" placeholder="포켓몬 검색">
               <button type="button" class="form-btn neutral monster-search">검색</button>
           </div>
           <img class="pocketmon-img float-right me-50" src="" width=180 height=180>
       </div>
           <div class="row">

               <div class="row">종족값</div>
               <div class="row flex-box w-100">
                   <div class="w-16">
                       체력<input name="baseHp" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       공격<input name="baseAtk" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       방어<input name="baseDef" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       특수공격<input name="baseSpAtk" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       특수방어<input name="baseSpDef" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       스피드<input name="baseSpd" class="form-input w-100" readonly>
                   </div>
               </div>
           </div>
           <div class="row">
               <div class="row">기본 노력치</div>
               <div class="row flex-box w-100">
                   <div class="w-16">
                       체력<input name="effortHp" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       공격<input name="effortAtk" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       방어<input name="effortDef" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       특수공격<input name="effortSpAtk" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       특수방어<input name="effortSpDef" class="form-input w-100" readonly>
                   </div>
                   <div class="w-16">
                       스피드<input name="effortSpd" class="form-input w-100" readonly>
                   </div>
               </div>
           </div>
           <div class="row">
               <div class="row">개체값(입력)</div>
               <div class="row flex-box w-100">
                   <div class="w-16">
                       체력<input name="indiHp" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       공격<input name="indiAtk" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       방어<input name="indiDef" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       특수공격<input name="indiSpAtk" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       특수방어<input name="indiSpDef" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       스피드<input name="indiSpd" placeholder="0" class="form-input w-100 need-write">
                   </div>
               </div>
           </div>
           <div class="row">
               <div class="row">추가 노력치(입력)</div>
               <div class="row flex-box w-100">
                   <div class="w-16">
                       체력<input name="addEffortHp" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       공격<input name="addEffortAtk" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       방어<input name="addEffortDef" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       특수공격<input name="addEffortSpAtk" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       특수방어<input name="addEffortSpDef" placeholder="0" class="form-input w-100 need-write">
                   </div>
                   <div class="w-16">
                       스피드<input name="addEffortSpd" placeholder="0" class="form-input w-100 need-write">
                   </div>
               </div>
           </div>
           <div class="row">
               레벨 : <input name="level" value="50" class="form-input w-20">
           </div>
           <div class="row">
               성격 : <select name="personality" class="form-input w-40">
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1,"spd":1}'>선택</option>
                   <option value='{"hp":1,"atk":1.1,"def":1,"spatk":1,"spdef":0.9,"spd":1}'>개구쟁이</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1.1,"spd":0.9}'>건방진</option>
                   <option value='{"hp":1,"atk":0.9,"def":1,"spatk":1,"spdef":1,"spd":1.1}'>겁쟁이</option>
                   <option value='{"hp":1,"atk":1.1,"def":1,"spatk":0.9,"spdef":1,"spd":1}'>고집스런</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1.1,"spdef":1,"spd":0.9}'>냉정한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1,"spd":1}'>노력하는</option>
                   <option value='{"hp":1,"atk":0.9,"def":1.1,"spatk":1,"spdef":1,"spd":1}'>대담한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1.1,"spdef":0.9,"spd":1}'>덜렁대는</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":0.9,"spdef":1,"spd":1.1}'>명랑한</option>
                   <option value='{"hp":1,"atk":1,"def":1.1,"spatk":1,"spdef":1,"spd":0.9}'>무사태평한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1,"spd":1}'>변덕스러운</option>
                   <option value='{"hp":1,"atk":1,"def":0.9,"spatk":1,"spdef":1,"spd":1.1}'>성급한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1,"spd":1}'>성실한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1,"spd":1}'>수줍은</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":0.9,"spdef":1.1,"spd":1}'>신중한</option>
                   <option value='{"hp":1,"atk":1,"def":0.9,"spatk":1,"spdef":1.1,"spd":1}'>얌전한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":1,"spd":1}'>온순한</option>
                   <option value='{"hp":1,"atk":1.1,"def":0.9,"spatk":1,"spdef":1,"spd":1}'>외로운</option>
                   <option value='{"hp":1,"atk":1.1,"def":1,"spatk":1,"spdef":1,"spd":0.9}'>용감한</option>
                   <option value='{"hp":1,"atk":1,"def":0.9,"spatk":1.1,"spdef":1,"spd":1}'>의젓한</option>
                   <option value='{"hp":1,"atk":1,"def":1.1,"spatk":0.9,"spdef":1,"spd":1}'>장난꾸러기</option>
                   <option value='{"hp":1,"atk":0.9,"def":1,"spatk":1.1,"spdef":1,"spd":1}'>조심스러운</option>
                   <option value='{"hp":1,"atk":0.9,"def":1,"spatk":1,"spdef":1.1,"spd":1}'>차분한</option>
                   <option value='{"hp":1,"atk":1,"def":1,"spatk":1,"spdef":0.9,"spd":1.1}'>천진난만한</option>
                   <option value='{"hp":1,"atk":1,"def":1.1,"spatk":1,"spdef":0.9,"spd":1}'>촐랑거리는</option>
               </select>
           </div>
           <div class="row"><button class="form-btn neutral calc-btn w-100">결과값 보기</button></div>
       <div class="row">
           <div class="row">예상 능력치값</div>
           <div class="row flex-box w-100"  Style="flex-wrap: wrap">
               <div class="w-16">
                   체력<span class="personal-hp"></span>
                   <div class="row w-100"><input style="display:inline-block" class="form-input w-100 get-hp" readonly></input></div>
               </div>
               <div class="w-16">
                   공격<span class="personal-atk"></span>
                   <div class="row w-100"><input style="display:inline-block" class="form-input w-100 get-atk" readonly></input></div>
               </div>
               <div class="w-16">
                   방어<span class="personal-def"></span>
                   <div class="row w-100"><input style="display:inline-block" class="form-input w-100 get-def" readonly></input></div>
               </div>
               <div class="w-16">
                   특수공격<span class="personal-spatk"></span>
                   <div class="row w-100"><input style="display:inline-block" class="form-input w-100 get-spatk" readonly></input></div>
               </div>
               <div class="w-16">
                   특수방어<span class="personal-spdef"></span>
                   <div class="row w-100"><input style="display:inline-block" class="form-input w-100 get-spdef" readonly></input></div>
               </div>
               <div class="w-16">
                   스피드<span class="personal-spd"></span>
                   <div class="row w-100"><input style="display:inline-block" class="form-input w-100 get-spd" readonly></input></div>
               </div>
           </div>
       </div>
   </div>
 </body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>