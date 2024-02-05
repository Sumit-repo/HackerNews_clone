package com.red_baton;

import java.io.IOException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({ "/login" })
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("acct");
        String password = req.getParameter("pw");
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("dev");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            Credentials check = (Credentials) entityManager.find(Credentials.class, username);
            if (check != null && check.getPassword().equals(password)) {
                req.setAttribute("username", username);
                req.getRequestDispatcher("index.jsp").include(req, resp);
            } else if (check == null) {
                resp.getWriter().println(
                        "<script type=\"text/javascript\">alert(\"User not in database, Please Create new account\");</script>");
                req.getRequestDispatcher("login.jsp").include(req, resp);
            } else {
                resp.getWriter().println(
                        "<script type=\"text/javascript\">alert(\"Invalid Credentials, Double check your password\");</script>");
                req.getRequestDispatcher("login.jsp").include(req, resp);
            }
        } finally {
            entityManager.close();
            entityManagerFactory.close();
        }

    }
}
