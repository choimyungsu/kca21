<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.calendar.CalendarDAO" %>  
<%@ page import="com.calendar.Calendar" %> 
<%@ page import="java.util.*, java.text.*"  %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='css/fullcalendar.min.css' rel='stylesheet' />
<link href='css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='js/lib/moment.min.js'></script>
<script src='js/lib/jquery.min.js'></script>
<script src='js/fullcalendar.min.js'></script>
<script src='js/ko.js'></script>
<script>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
String today = formatter.format(new java.util.Date());

CalendarDAO calendarDAO = new CalendarDAO();
String calendarListJSON ="";
calendarListJSON = calendarDAO.getCalendarListJSON(today);

//System.out.println(today);
String userID = "";
if(session.getAttribute("userID") !=null ){
    userID = (String) session.getAttribute("userID");
}

%>



  $(document).ready(function() {
	  var initialLocaleCode = 'ko';
     // var calendar1 = $('#calendar').fullCalendar();
    var calendar = $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay,listWeek'
      },
      defaultDate: '<%= today%>',
      locale: initialLocaleCode,
      navLinks: true, // can click day/week names to navigate views
      eventLimit: true, // allow "more" link when too many events (true or false)
     
      <%= calendarListJSON%>,
      
      selectable:true,
      selectHelper:true,
      <% if(userID.equals("cms")){ %>
      select:function(start, end, allDay)
      {
    	  var title = prompt("일정을 입력하세요");
    	  if(title)
    	  {
	    		var start =  $.fullCalendar.formatDate(start,"Y-MM-DD HH:mm:ss");
	    		var end =  $.fullCalendar.formatDate(end,"Y-MM-DD HH:mm:ss");
	    		$.ajax({
	    			url:"calendarInsert.jsp",
	    			type:"POST",
	    			data:{title:title, start:start, end:end},
	    			success:function()
	    			{
	    				// 리프레쉬 구현 필요
	    				//calendar.fullCalendar('rerenderEvents');
	    				//$('#calendar').fullCalendar('rerenderEvents');
	    				$('#calendar').fullCalendar('rerenderEvents');
	    			   // $('#calendar').fullCalendar('rerenderEvents');
	    				alert("일정이 등록 되었습니다.");
	    			}
	    		})
    	   }
      },
      editable: true,
      eventResize:function(event)
      {
    	  var start = $.fullCalendar.formatDate(event.start,"Y-MM-DD HH:mm:ss");
    	  var end = $.fullCalendar.formatDate(event.end,"Y-MM-DD HH:mm:ss");
    	  var title = event.title;
    	  var id = event.id;
    	  var calendarID = event.calendarID;
    	  $.ajax({
              url:"calendarUpdate.jsp",
              type:"POST",
              data:{title:title, start:start, end:end, id:id, calendarID:calendarID},
              success:function()
              {
            	  //calendar.fullCalendar('rerenderEvents');
            	  $('#calendar').fullCalendar('rerenderEvents');
                  alert("일정이 수정 되었습니다.");
              }
          })
    	  
      },
      
      eventDrop:function(event)
      {
    	  var start = $.fullCalendar.formatDate(event.start,"Y-MM-DD HH:mm:ss");
          var end = $.fullCalendar.formatDate(event.end,"Y-MM-DD HH:mm:ss");
          var title = event.title;
          var id = event.id;
          var calendarID = event.calendarID;
          $.ajax({
              url:"calendarUpdate.jsp",
              type:"POST",
              data:{title:title, start:start, end:end, id:id, calendarID:calendarID},
              success:function()
              {
            	 //calendar.fullCalendar('rerenderEvents');
            	  $('#calendar').fullCalendar('rerenderEvents');
                  alert("일정이 수정 되었습니다.");
              }
          })          
    	  
      },
      
      eventClick:function(event)
      {
    	  if(confirm("삭제하시겠습니까?"))
    	  {
    		  var calendarID = event.calendarID;
    		  $.ajax({
                  url:"calendarDelete.jsp",
                  type:"POST",
                  data:{calendarID:calendarID},
                  success:function()
                  {
                	  //calendar.fullCalendar('rerenderEvents');
                	  $('#calendar').fullCalendar('rerenderEvents');
                      alert("일정이 삭제 되었습니다.");
                  }
              })    
    	  }
      }
      <%}%>

      /*
      events: [
        {
          title: 'All Day Event',
          start: '2018-03-01',
        },
        {
          title: 'Long Event',
          start: '2018-03-07',
          end: '2018-03-10'
        },
        {
          id: 999,
          title: 'Repeating Event',
          start: '2018-03-09T16:00:00'
        },
        {
          id: 999,
          title: 'Repeating Event',
          start: '2018-03-16T16:00:00'
        },
        {
          title: 'Conference',
          start: '2018-03-11',
          end: '2018-03-13'
        },
        {
          title: 'Meeting',
          start: '2018-03-12T10:30:00',
          end: '2018-03-12T12:30:00'
        },
        {
          title: 'Lunch',
          start: '2018-03-12T12:00:00'
        },
        {
          title: 'Meeting',
          start: '2018-03-12T14:30:00'
        },
        {
          title: 'Happy Hour',
          start: '2018-03-12T17:30:00'
        },
        {
          title: 'Dinner',
          start: '2018-03-12T20:00:00'
        },
        {
          title: 'Birthday Party',
          start: '2018-03-13T07:00:00'
        },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: '2018-03-28'
        }
      ]
      
      */
    });

  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>
</head>
<body>

  <div id='calendar'></div>

</body>
</html>
