package syy.Servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileExistsException;
import syy.Bean.url;
import syy.util.JsonUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

//@MultipartConfig
@WebServlet(name = "FileUploadServlet", value = "/FileUploadServlet")
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        DiskFileItemFactory fileItemFactory  =  new DiskFileItemFactory();
//        创建文件上传核心类
        ServletFileUpload upload = new  ServletFileUpload(fileItemFactory);
        upload.setFileSizeMax(30*1024*1024);//设置单个文件最大值30M
        upload.setSizeMax(50*1024*1024);//最多50个文件
//        判断表单是否是文件上传表单
        if(upload.isMultipartContent(request)) {
//            把请求数据转化为FileItem对象集合
            try {
                List<FileItem> list = upload.parseRequest(request);
//                遍历得到每一个数据项
                for(FileItem fileItem :list) {
//                    判断普通项，还是文件。
                    if(fileItem.isFormField()) {
                        //普通表单项
                        String fieldName =fileItem.getFieldName();//表单元素名称
                        String content =fileItem.getString("UTF-8");//值
//                        System.out.print(fieldName+"\n"+content+"\n\n");
                    }else {
                        //文件上传表单项
                        String name =fileItem.getName();//获取文件名
                        //上传文件目录路径
                        String basePath =request.getServletContext().getRealPath("/upload");
//                        String basePath1 =request.getContextPath()+"/upload";
//                        System.out.println(basePath1);

                        //新建文件
                        File file = new File(basePath,name);
                        try {
                            fileItem.write(file);
                        }catch (FileExistsException ignored){
                        }
                        catch (IOException e)
                        {
                            System.out.println(basePath);
                        }

                        fileItem.delete();//删除临时文件
//                        String retrun = basePath+File.separator+name;
                        String retrun =request.getContextPath()+ "/upload/"+name;
                        url url = new url(retrun);
                        System.out.println(retrun);
                        response.getWriter().write(JsonUtils.objectToJson(url));
                        System.out.println(JsonUtils.objectToJson(url));
                    }
                }
            } catch (FileUploadException e) {
//                 TODO Auto-generated catch block
                e.printStackTrace();
            } catch (Exception e) {
//                 TODO Auto-generated catch block
                e.printStackTrace();
            }
        }else {
            System.out.print("不是文件上传表单，不处理");
        }
    }
}

