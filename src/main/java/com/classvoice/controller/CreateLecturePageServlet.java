package com.classvoice.controller;
import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import jakarta.servlet.*; import java.io.IOException;
@WebServlet("/teacher/create") public class CreateLecturePageServlet extends HttpServlet { protected void doGet(HttpServletRequest r,HttpServletResponse p)throws ServletException,IOException{r.getRequestDispatcher("/WEB-INF/views/create-lecture.jsp").forward(r,p);} }
