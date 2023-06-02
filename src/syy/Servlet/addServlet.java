package syy.Servlet;

import syy.Bean.Worker;
import syy.util.DbUtils;
import syy.util.JsonUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "addServlet", value = "/addServlet")
public class addServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        String workerCode = request.getParameter("workerCode");
        int flag = 0;
        String sql1 = "select * from WorkerInfo where workerCode=" + "'" + workerCode + "'";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement st = conn.prepareStatement(sql1)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    flag = 1;
                    System.out.println("有重复");
                    String str = "{\"flag\":\"true\"}";
                    response.getWriter().write(str);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (flag == 0) {
            String siteName = request.getParameter("siteName");
            String workerName = request.getParameter("workerName");
            String workerSex = request.getParameter("workerSex");
            String workerBirthday = request.getParameter("workerBirthday");
            String workerAddress = request.getParameter("workerAddress");
            String workerPhone = request.getParameter("workerPhone");
            String workerJob = request.getParameter("workerJob");
            String workerPosition = request.getParameter("workerPosition");
            String registerTime = request.getParameter("registerTime");
            String workerPhoto = request.getParameter("workerPhoto");
            String sql = "insert into WorkerInfo(siteName,workerCode,workerName,workerSex,workerBirthday,workerAddress,workerPhone,workerJob,workerPosition,registerTime,workerPhoto)" + " values(?,?,?,?,?,?,?,?,?,?,?)";
            try (Connection conn = DbUtils.getConnection();
                 PreparedStatement st = conn.prepareStatement(sql)) {
                st.setString(1, siteName);
                st.setString(2, workerCode);
                st.setString(3, workerName);
                st.setString(4, workerSex);
                st.setDate(5, Date.valueOf(workerBirthday));
                st.setString(6, workerAddress);
                st.setString(7, workerPhone);
                st.setString(8, workerJob);
                st.setString(9, workerPosition);
                st.setTimestamp(10, Timestamp.valueOf(registerTime));
                st.setString(11, workerPhoto);
                int ret = st.executeUpdate();
                Worker worker = new Worker(workerName, workerCode, siteName, workerBirthday, registerTime);
                response.getWriter().write(JsonUtils.objectToJson(worker));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
