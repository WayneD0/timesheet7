package com.timesheet.login;

import com.timesheet.bean.Employee;
import com.timesheet.util.LoggerUtils;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

public class ForgotPasswordController extends SimpleFormController {

    private LoginService loginService;

    public LoginService getLoginService() {
        return loginService;
    }

    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    public ForgotPasswordController() {
        setCommandClass(Employee.class);
        setCommandName("forpassword");
    }

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
        String XPath = request.getServletPath();
        LoggerUtils.info("Inside ForgotPasswordController=====>");
        try {
            String recipient = request.getParameter("email");
            String email = loginService.checkEmailID(recipient);
            if (email == null) {
                String message = "Please Enter correct Email ID";
                return new ModelAndView("forgotpassword", "mes", message);
            } else {
                String message = "UserName And Password Have been Sent to your EMail";
                Employee e = (Employee) loginService.getUserPassword(recipient);
                //System.out.println("=== In fp level else ====");
                HttpSession session = request.getSession(false);
                if (session == null) {
                    session = request.getSession();
                }
                session.setAttribute("emailSession", e);
                //System.out.println("emailSession: " + session.getAttribute("emailSession"));
                Employee emp = (Employee) session.getAttribute("emailSession");
                String empid = emp.getEmp_id();
                String emp_password = emp.getEmp_password();
                LoggerUtils.info("emp_id: " + empid + "emp_password: " + emp_password);
                EmailBean emailBean = new EmailBean();
                emailBean.setEmailSubject("TIMESHEET - Password Reminder");
                emailBean.setEmailDate(new Date());
                emailBean.setHTMLContents(true);
                emailBean.setFromAddress("ankioza@gmail.com");
                emailBean.setToAddress(recipient);
                StringBuffer startMessage = new StringBuffer("");
                startMessage.append("<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>");
                startMessage.append("<html><head><style type='text/css'>h2 {color:#520000}</style>");
                startMessage.append("<meta content='text/html; charset=ISO-8859-1' http-equiv='content-type'>");
                startMessage.append("</head><body>");
                startMessage.append("<h2>Welcome To ProdigyInfosoft TimeSheet Service</h2><br><br>");
                startMessage.append("<strong>Your login details are as follows:</strong><br><br>");
                startMessage.append("<table border='0' style='text-align: left; font-family: verdana;' cellpadding='2' cellspacing='2'>");
                startMessage.append("<tr>");
                startMessage.append("<td style='vertical-align:top;background:#F5F5F5;border:1px solid #520000;'>UserID  : " + empid + "</td></tr>");
                startMessage.append("<tr><td style='vertical-align:top;background:#F5F5F5;border:1px solid #520000;'>Password   : " + emp_password + "</td></tr></table>");
                startMessage.append("<br>");
                startMessage.append("<br><br>Thanks<br>TimeSheet Services<br>Prodigy Infosoft Pvt Ltd.</BODY></HTML>");
                emailBean.setEmailMesaage(startMessage.toString());
                EmailService emailService1 = new EmailService();
                emailService1.sendEmail(emailBean);
                return new ModelAndView("forgotpassword", "message", message);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("backpage", XPath);
            return new ModelAndView("error");
        }
    }

}
