<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .flex {
    display: flex;
  }
  .picOne {
    width: 33.33%;
  }
  .picCon {
    height: 300px;
  }
</style>

<script>
  $(function(){
    $(".ajax-btn1").click(ajax1);
    $(".ajax-btn2").click(ajax2);
    $(".ajax-btn3").click(ajax3);
    // $(".ajax-btn4").click(ajax4);
    // $(".ajax-btn5").click(ajax5);

    function ajax1(){
      $.ajax({
        url: "/restTest/test",
        method: "get",
        data: {param1:10, param2:20},
        success: function(response){
          console.log(response);
        },
        error: function(){
          console.log("test1 통신에러")
        }
      });
    }
    function ajax2(){
    $.ajax({
      url: "/restTest/test2",
      method: "get",
      data: {param1:10, param1:20},
      success: function(response){
        console.log(response);
      },
      error: function(){
        console.log("test2 통신에러")
      }
    })
    }
    function ajax3(){
    $.ajax({
      url: "/restTest/test3",
      method: "get",
      data: {param:[10, 10, 10]},
      success: function(response){
        console.log(response);
      },
      error: function(){
        console.log("test3 통신에러")
      }
    })
    }
  }
  )

</script>
<!-- section -->
<section test>
  <!-- aside -->
  <aside></aside>

  <!-- article -->
  <article class="container-600">
    <div class="row flex picCon">
      <div class="w-60 flex-column-grow">
        <div class="flex-row-grow">
          <div class="picOne">첫번째사진</div>
          <div class="picOne">두번째사진</div>
          <div class="picOne">세번째사진</div>
        </div>
        <div class="flex-row-grow">
          <div class="picOne">네번째사진</div>
          <div class="picOne">다섯번째사진</div>
          <div class="picOne">여섯번째사진</div>
        </div>
      </div>
      <div class="w-40">대문사진</div>
    </div>
    <div class="row">
      <div class="row">
        <button class="ajax-btn1">버튼1</button>
      </div>
      <div class="row">
        <button class="ajax-btn2">버튼2</button>
      </div>
      <div class="row">
        <button class="ajax-btn3">버튼3</button>
      </div>
      <div class="row">
        <button class="ajax-btn4">버튼4</button>
      </div>
      <div class="row">
        <button class="ajax-btn5">버튼5</button>
      </div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
