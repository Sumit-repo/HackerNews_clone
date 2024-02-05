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

@WebServlet({ "/register" })
public class Register extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("R-acct");
        String password = req.getParameter("R-pw");
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("dev");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            Credentials check = (Credentials) entityManager.find(Credentials.class, username);
            if (check != null) {
                resp.getWriter().println(
                        "<script type=\"text/javascript\">alert(\"Username already in use, try another.\");</script>");
                req.getRequestDispatcher("login.jsp").include(req, resp);
            } else {
                Credentials newCredentials = new Credentials(username, password);
                entityManager.getTransaction().begin();
                entityManager.persist(newCredentials);
                entityManager.getTransaction().commit();
                resp.getWriter()
                        .println("<script type=\"text/javascript\">alert(\"Registerd, Login and procced.\");</script>");
                req.getRequestDispatcher("login.jsp").include(req, resp);
            }
        } finally {
            entityManager.close();
            entityManagerFactory.close();
        }

    }
}