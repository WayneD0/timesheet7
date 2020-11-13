<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="com.timesheet.bean.EmpTransaction" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.timesheet.bean.Employee" %>
<%@page import="java.util.*"%>
<%@page import="com.timesheet.bean.EmpTransaction" %>
<%@page import="com.timesheet.bean.Project" %>
<%@page import="com.timesheet.bean.AssignBy" %>
<%@page import="java.lang.Object"%>
<% java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
    TimeZone istTime = TimeZone.getTimeZone("IST");
    sdf.setTimeZone(istTime);
    String dt = request.getParameter("dt1") == null ? sdf.format(new Date()) : request.getParameter("dt1").toString();
%>
<%  java.util.ArrayList<String> yearList = new java.util.ArrayList<String>();
    java.util.ArrayList<Employee> employeeList = new java.util.ArrayList<Employee>();

    yearList = (java.util.ArrayList<String>) request.getSession().getAttribute("YEAR_LIST");
    employeeList = (java.util.ArrayList<Employee>) request.getSession().getAttribute("EMPLIST");

    java.util.ArrayList<AssignBy> assignbyList = new java.util.ArrayList<AssignBy>();

    java.util.ArrayList<Project> projectList = new java.util.ArrayList<Project>();

    assignbyList = (java.util.ArrayList) request.getSession().getAttribute("assign_by_list");

    projectList = (java.util.ArrayList) request.getSession().getAttribute("project_list");
%>
<link rel="stylesheet" href="default.css" />
<link rel="stylesheet" href="jquery.ui.core.css" />
<link rel="stylesheet" href="jquery.ui.theme.css" />
<link rel="stylesheet" href="jquery.ui.datepicker.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ui.datepicker.js"></script>
<script type='text/javascript' src="${pageContext.request.contextPath}/js/jRounded.js"></script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title></title>
        <link rel="stylesheet" href="default.css" />
        <script>
            $(document).ready(function() {
                $('.boxMe').box();
                $('.oxMe').box();
                $('.otherOne, .anotherOne').box();
            });
        </script>
        <script language="javascript">
            <%--function checkType(){
                for(var i=0; i<document.empReportFrm.id.length; i++){
                    if (document.empReportFrm.id[i].checked)
                    {
                        var rad1 = document.empReportFrm.id[i].value;
                    }
                }
                if(rad1=='datewise'){
                    var dt = document.getElementById('datewise_txt').value;
                    if(dt!=''){
                        document.getElementById('employeereport').target = "_blank";
                        document.empReportFrm.submit();
                    }else{
                        alert("Enter Date");
                    }
                }else if(rad1=="customdate"){
                    var dt1 = document.getElementById('customdate_txt1').value;;
                    var dt2 = document.getElementById('customdate_txt2').value;
                    if(dt1!='' && dt2!=''){
                        document.getElementById('employeereport').target = "_blank";
                        document.empReportFrm.submit();
                    }else{
                        alert("Enter Date");
                    }
                }else if(rad1=="monthwise"){
                    var month = document.getElementById('monthlist').value;
                    var year =  document.getElementById('yearlist').value;
                    if(month!=0 && year!=0){
                        document.getElementById('employeereport').target = "_blank";
                        document.empReportFrm.submit();
                    }else{
                        alert("Select Month or Year");
                    }
                }else if(rad1 == "yearwise"){
                    var year = document.getElementById('yearlist1').value;
                    if(year!=0){
                        document.getElementById('employeereport').target = "_blank";
                        document.empReportFrm.submit();
                    }else{
                        alert("Select Year");
                    }
                }else{
                    alert("Select Report Type");
                }
            }--%>


                function checkType(){
                   

                       
                        
                    if (document.empReportFrm.id.checked)
                    {
                        var rad1 = document.empReportFrm.id.value;
 
                    }
                    
                    for(var i=0; i<document.empReportFrm.reportType.length; i++){
                        if (document.empReportFrm.reportType[i].checked)
                        {
                            var rad2 = document.empReportFrm.reportType[i].value;

                        }
                    }

                    if(rad2 == "excel"){
                        if(rad1 == "criteria"){
 
                            var start_date = document.getElementById('criteria_txt1').value;
                            var end_date = document.getElementById('criteria_txt2').value;
                            var emp_id = document.getElementById('emplist1').value;
                            var assign_by_id = document.getElementById('assign_by_id').value;
                            var proj_id = document.getElementById('proj_id').value;

                            if(start_date != "" && end_date != ""){
                                if(emp_id != ""){
                                    if(assign_by_id != ""){
                                        if(proj_id != ""){
                                            if(emp_id == "all" && assign_by_id == "0" && proj_id == "0"){
                                                // alert("1");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "customdateExcel1.xls?customdate_txt1="+start_date+"&customdate_txt2="+end_date+"&type=customdate";
                                            }else if(assign_by_id == "0" && proj_id == "0" ){
                                                //alert("2");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "report2Excel1.xls?start_date="+start_date+"&end_date="+end_date+"&emp_id="+emp_id+"&type=catagory&cat=report2";
                                            }else if(emp_id == "all" && proj_id == "0" ){
                                                //alert("3");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "assigncatagoryExcel1.xls?start_date="+start_date+"&end_date="+end_date+"&assign_by_id="+assign_by_id+"&type=catagory&cat=assign";
                                            }else if(emp_id == "all" && assign_by_id == "0"){
                                                // alert("4");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "projectcatagoryExcel1.xls?start_date="+start_date+"&end_date="+end_date+"&proj_id="+proj_id+"&type=catagory&cat=project";
                                            }else if(proj_id == "0" ){
                                                //alert("5");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "report5Excel1.xls?start_date="+start_date+"&end_date="+end_date+"&emp_id="+emp_id+"&assign_by_id="+assign_by_id+"&cat=report5&type=catagory";
                                            }else if(assign_by_id == "0" ){
                                           
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "report6Excel1.xls?start_date="+start_date+"&end_date="+end_date+"&emp_id="+emp_id+"&proj_id="+proj_id+"&cat=report6&type=catagory";
                                            }else if(emp_id == "all"){
                                                //alert("7");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "report7Excel1.xls?start_date="+start_date+"&end_date="+end_date+"&assign_by_id="+assign_by_id+"&proj_id="+proj_id+"&cat=report7&type=catagory";
                                            }else{
                                                //  alert("8");
                                                document.getElementById('employeereport').target = "_blank";
                                                document.location.href = "report8Excel1.xls?start_date="+start_date+"&end_date="+end_date+"&emp_id="+emp_id+"&proj_id="+proj_id+"&cat=report8"+"&assign_by_id="+assign_by_id+"&type=catagory";
                                            }
                                        }else{
                                            alert("Select Project");
                                            document.getElementById('proj_id').focus();
                                        }
                                    }else{
                                        alert("Select Assign By");
                                        document.getElementById('assign_by_id').focus();
                                    }
                                }else{
                                    alert("Select Employee");
                                    document.getElementById('emplist1').focus();
                                }
                            }else{
                                alert("Select Start Date and End Date");
                            }
                        }else{
                            alert("Select Report Type");
                        }
                    }else if(rad2 == "pdf"){
                        if(rad1 == "criteria"){
                            var start_date1 = document.getElementById('criteria_txt1').value;
                            var end_date1 = document.getElementById('criteria_txt2').value;
                            var emp_id = document.getElementById('emplist1').value;
                            var assign_by_id = document.getElementById('assign_by_id').value;
                            var proj_id = document.getElementById('proj_id').value;

                            if(start_date1!="" && end_date1!=""){
                                if(emp_id!=""){
                                    if(assign_by_id!=""){
                                        if(proj_id!=""){
                                            //     document.getElementById('adminreport').target = "_blank";
                                            document.getElementById('employeereport').target = "_top";
                                            document.forms.empReportFrm.submit();
                                        }else{
                                            alert("Select Project");
                                            document.getElementById('proj_id').focus();
                                        }
                                    }else{
                                        alert("Select AssignBy");
                                        document.getElementById('assign_by_id').focus();
                                    }
                                }else{
                                    alert("Select Employee");
                                    document.getElementById('emplist1').focus();
                                }
                            }else{
                                alert("Select Start Date and End Date");
                            }
                        }else{
                            alert("Select Report Type");
                        }
                    }else{
                        alert("Select Report Type (pdf/excel)");
                    }
                }
                function getVisible6(){
                    document.getElementById('criteria_td').style.visibility = "visible";
                    document.getElementById('lbl3').style.display="";
                    document.getElementById('date_txt1').style.display="";
                    document.getElementById('datewise_txt').style.visibility = "hidden";
                    document.getElementById('lbl1').style.visibility="hidden";
                    document.getElementById('daily_txt').style.visibility = "hidden";
                    document.getElementById('lbl7').style.visibility="hidden";
                    document.getElementById('customdate_txt1').style.display = "";
                    document.getElementById('customdate_txt2').style.visibility = "hidden";
                    document.getElementById('lbl2').style.visibility="hidden";
                    document.getElementById('date_txt').style.display="none";
                    document.getElementById('monthlist').style.visibility = "hidden";
                    document.getElementById('monthlist2').style.visibility = "hidden";
                    document.getElementById('yearlist').style.visibility = "hidden";
                    document.getElementById('yearlist1').style.visibility = "hidden";
                    document.getElementById('yearlist2').style.visibility = "hidden";
                    document.getElementById('emplist').style.visibility = "hidden";
                    document.forms.empReportFrm.assign_by_id[0].selected = "1";
                    document.forms.empReportFrm.proj_id[0].selected = "1";
                    document.getElementById('rmsg').style.visibility = "hidden";
                    //   document.getElementById('pdftype').style.visibility = "hidden";
                }
        </script>

    </head>
    <body>
        <div class="anotherOne"><center><font face="arial" style="font-size:16px;font-weight:bold;" color="#FFFFFF">View Reports</font></center></div>
        <form:form  name="empReportFrm" id="employeereport"  action="employeereport.htm">
            <div class="anotherOne bg-white" style="min-height:245px;">

                <div style="border:1px solid #520000;">
                    <div>
                        <div style="margin-left:5px;">
                            <div style="height:1em;"></div>

                            <div>
                                <div style="width:150px;float:left"> <input type="radio" id="criteria" name="id" value="criteria"  title="Criteria-Wise Report" onclick="getVisible6()" style="float:left;"float:left>Criteria-Wise</div>
                                <div id="criteria_td" style="visibility:hidden;">
                                    <div style="border:1px solid black;">
                                        <input style="border:1px solid #520000;" size="8" type="text" id="criteria_txt1" name="criteria_txt1" value="<%=dt%>" />
                                        <input style="border:1px solid #520000;" size="8" type="text" id="criteria_txt2" name="criteria_txt2" value="<%=dt%>" />

                                        <select style="border:1px solid #520000;" id="emplist1" name="emplist1">
                                            <option value="" >--Employee--</option>
                                            <option value="all" >-All-</option>
                                            <%for (int i = 1; i < employeeList.size(); i++) {
                                                    Employee emp11 = (Employee) employeeList.get(i);
                                            %>
                                            <c:set var="roll11" value="<%=emp11.getRole_id()%>"/>
                                            <c:set var="rollid11" value="3"/>

                                            <c:if test="${roll11 ne rollid11}">
                                                <option value="<%=emp11.getEmp_id()%>" ><%=emp11.getEmp_fname()%><%=" "%><%= emp11.getEmp_lname()%></option>
                                            </c:if>
                                            <%}%>
                                        </select>


                                        <select style="border:1px solid #520000;" id="assign_by_id" name="assign_by_id" >
                                            <option value="" >--AssignBy--</option>
                                            <option value="0" >All</option>
                                            <%for (int j = 0; j < assignbyList.size(); j++) {
                                                    AssignBy ab1 = (AssignBy) assignbyList.get(j);
                                            %>
                                            <option value="<%=ab1.getAssign_by_id()%>"><%=ab1.getAssign_by_name()%></option>
                                            <%}%>


                                        </select>

                                        <select style="border:1px solid #520000;" id="proj_id" name="proj_id" >
                                            <option value="">--Project--</option>
                                            <option value="0">All</option>
                                            <%for (int k = 0; k < projectList.size(); k++) {
                                                    Project proj1 = (Project) projectList.get(k);
                                            %>
                                            <option value="<%=proj1.getProj_id()%>"><%=proj1.getProj_name()%></option>
                                            <%}%>

                                        </select>
                                    </div>

                                </div>
                            </div>
                            <div style="height:1em;"></div>

                        </div>

                        <div style="margin:2px;border:1px solid #520000;">
                            <table>
                                <tr>
                                    <td><input type="radio" name="reportType" value="excel">Excel</td>
                                    <td><input type="radio" name="reportType" value="pdf">PDF</td>

                                </tr>
                                <tr>
                                    <td style="color:red; font-size:14px; padding-left:10px;"><c:out value="${rmsg}" /></td>
                                </tr>
                            </table>
                        </div>
                        <table>
                            <tr>
                                <td>
                                    <input class="button" type="button" value="submit" onclick="checkType()">
                                </td>
                            </tr>
                        </table> 
                    </div>
                </div>
            </div>
        </form:form>

    </body> 
    <script type="text/javascript">
        $(function() {
 
            $('#criteria_txt1').datepicker({
                changeMonth: true,
                changeYear: true
            });
            $('#criteria_txt2').datepicker({
                changeMonth: true,
                changeYear: true
            });
        });
    </script>

</html>
