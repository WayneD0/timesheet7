package com.timesheet.login;

import com.timesheet.bean.Employee;
import com.timesheet.emptransaction.EmpTransactionService;
import com.timesheet.report.AdminReportService;
import com.timesheet.util.LoggerUtils;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.mock.MockAction;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

public class ChangePasswordController extends SimpleFormController {

    private LoginService loginService;
    private EmpTransactionService empTransactionService;
    private AdminReportService adminReportService;


    public AdminReportService getAdminReportService() {
        return adminReportService;
    }

    public void setAdminReportService(AdminReportService adminReportService) {
        this.adminReportService = adminReportService;
    }

    public EmpTransactionService getEmpTransactionService() {
        return empTransactionService;
    }

    public void setEmpTransactionService(EmpTransactionService empTransactionService) {
        this.empTransactionService = empTransactionService;
    }

    public LoginService getLoginService() {
        return loginService;
    }

    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    public ChangePasswordController() {

        setCommandClass(Employee.class);
        setCommandName("changepass");
    }

    @Override
    protected Object formBackingObject(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        session.setAttribute("EMPLIST", adminReportService.getEmployees());
        return super.formBackingObject(request);
    }

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
        LoggerUtils.info("In Class ChangePasswordController.java===>> onSubmit() Method :: Enter");
        String XPath = request.getServletPath();
        try {
            Employee emp1 = (Employee) command;
            String msg = "";
            emp1 = (Employee) request.getSession().getAttribute("emp");
            String emp_id = emp1.getEmp_id();
            String oldpass = request.getParameter("oldpass");
            String newpass = request.getParameter("newpass");
            String confirmpass = request.getParameter("confirmpass");
           // System.out.println("parameters from jsp: " + oldpass + "," + newpass + "," + confirmpass);
            if (oldpass != null || newpass != null || confirmpass != null) {
                if (!oldpass.equals(loginService.getpassword(emp_id))) {
                    msg = "Old Password does not exist";
                    return new ModelAndView("changepassword", "msg", msg);
                } else {
                    if (oldpass.equals(newpass)) {
                        msg = "Old PassWord and New Password can not be same";
                        return new ModelAndView("changepassword", "msg", msg);
                    } else {
                        if (newpass.equals(confirmpass)) {
                           // System.out.println("The Newpassword is==" + newpass);
                            if (!newpass.equals("") || confirmpass.equals("")) {
                              //  System.out.println("Newpassword length is==" + newpass.length());
                                if (newpass.length() >= 6 && confirmpass.length() >= 6) {

                                    loginService.changepassword(emp_id, newpass);
                                    HttpSession session = request.getSession();
                                    Employee emp = (Employee) session.getAttribute("emp");
                                    int id = emp.getRole_id();
                                    String  successmsg = "Your Password has been successfully changed ";
                                    return new ModelAndView("changepassword","successmsg",successmsg);
//                                    if (id == 1) {
//                                        return new ModelAndView("adminhome", "msg", msg);
//                                    } else if (id == 2) {
//                                        String stat = loginService.getStatus(emp_id);
//                                        session.setAttribute("et", stat);
//                                        Map<String, Object> emp_trans_list = new HashMap<String, Object>();
//                                        emp_trans_list.put("curr_trans", empTransactionService.getCurrentTransaction(emp_id));
//                                        emp_trans_list.put("msg", msg);
//                                        return new ModelAndView("emphome", "trans_list", emp_trans_list);
//                                    } else if (id == 3) {
//                                        return new ModelAndView("receptionisthome", "msg", msg);
//                                    } else {
//                                        return new ModelAndView("index");
//                                    }
                                } else {
                                    msg = "Password must be grater than six character ";
                                    return new ModelAndView("changepassword", "msg", msg);
                                }
                            } else {
                                msg = "Required Field is Mandatory ";
                                return new ModelAndView("changepassword", "msg", msg);
                            }
                        } else {
                            msg = "New Password And Confirm password Does not Match";
                            return new ModelAndView("changepassword", "msg", msg);
                        }
                    }
                }

            } else {
                msg = "Required Field is Mandatory ";
                return new ModelAndView("changepassword", "msg", msg);

            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("backpage", XPath);
            return new ModelAndView("error");
        }
    }

//    @Override
//    protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        return new ModelAndView("changepassword");
//    }


}


