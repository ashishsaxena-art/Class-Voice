package com.classvoice.filter;
import com.classvoice.model.User; import jakarta.servlet.*; import jakarta.servlet.annotation.WebFilter; import jakarta.servlet.http.*; import java.io.IOException;
@WebFilter(urlPatterns={"/teacher/*","/student/*"})
public class AuthFilter implements Filter {
 public void doFilter(ServletRequest req,ServletResponse res,FilterChain chain)throws IOException,ServletException{HttpServletRequest r=(HttpServletRequest)req;HttpServletResponse p=(HttpServletResponse)res;User u=(User)r.getSession().getAttribute("user");if(u==null){p.sendRedirect(r.getContextPath()+"/login.jsp?error=login-required");return;}String path=r.getRequestURI().substring(r.getContextPath().length());if(path.startsWith("/teacher/")&&!"teacher".equals(u.getRole())){p.sendRedirect(r.getContextPath()+"/student/dashboard?error=wrong-role");return;}if(path.startsWith("/student/")&&!"student".equals(u.getRole())){p.sendRedirect(r.getContextPath()+"/teacher/dashboard?error=wrong-role");return;}chain.doFilter(req,res);}
}
