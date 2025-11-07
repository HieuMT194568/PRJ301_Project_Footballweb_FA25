package Controller;

import Dal.MatchDAO;
import Dal.ProductDAO;
import Model.Match;
import Model.Product;

import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName; 

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/ai-chat"})
public class ChatbotServlet extends HttpServlet {

    // CHUYỂN SANG CHẾ ĐỘ GIẢ LẬP (MOCK MODE) ĐỂ PHÁT TRIỂN TIẾP
    private static final boolean MOCK_MODE = true; 

    // CHỈ DÙNG TRONG CHẾ ĐỘ API THẬT
    private static final String OPENAI_API_KEY = "KEY_HIEN_TAI_BI_LOI_HOAC_HET_TIEN";
    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
    
    private HttpClient httpClient;
    private Gson gson;
    private MatchDAO matchDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            this.matchDAO = new MatchDAO(Dal.DBContext.getConnection());
            this.productDAO = new ProductDAO();
            this.httpClient = HttpClient.newHttpClient();
            this.gson = new Gson();
            
            System.out.println("Chatbot AI (OpenAI) đã khởi tạo thành công! MOCK_MODE: " + MOCK_MODE);

        } catch (Exception e) {
            throw new ServletException("Không thể khởi tạo ChatbotServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String userQuery = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        
        String responseMessage = "";
        
        try {
            if (MOCK_MODE) {
                // CHẾ ĐỘ 1: MOCK MODE (Tự trả lời)
                responseMessage = getMockResponse(userQuery);
            } else {
                // CHẾ ĐỘ 2: LIVE API CALL (Cần tiền)
                String systemPrompt = buildSystemPrompt(userQuery);
                responseMessage = getOpenAIResponse(systemPrompt, userQuery);
            }

        } catch (Exception e) {
            e.printStackTrace();
            responseMessage = "Xin lỗi, tôi đang gặp lỗi: " + e.getMessage();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Map<String, String> jsonResponse = new HashMap<>();
        jsonResponse.put("reply", responseMessage);
        
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
    
    // =========================================================================
    // HÀM TRẢ LỜI GIẢ LẬP (MOCK RESPONSE) - SỬ DỤNG KHI HẾT TIỀN
    // =========================================================================
    private String getMockResponse(String userQuery) throws SQLException {
        userQuery = userQuery.toLowerCase();
        
        if (userQuery.contains("trận đấu") || userQuery.contains("phân tích")) {
            List<Match> matches = matchDAO.getAllMatchesWithTeamNames();
            if (matches.isEmpty()) {
                return "Tôi không tìm thấy dữ liệu trận đấu nào để phân tích.";
            }
            // Gợi ý trận đấu gần nhất
            Match latest = matches.get(0); 
            return String.format(
                "Trận đấu gần nhất là %s vs %s vào ngày %s với tỷ số %d - %d.",
                latest.getHomeTeamName(), latest.getAwayTeamName(), 
                latest.getMatchDate().toString().substring(0, 10), latest.getHomeScore(), latest.getAwayScore()
            );
            
        } else if (userQuery.contains("sản phẩm") || userQuery.contains("áo đấu") || userQuery.contains("mua sắm")) {
            List<Product> products = productDAO.getAllProducts();
            if (products.isEmpty()) {
                 return "Không có sản phẩm nào trong cửa hàng để gợi ý.";
            }
            // Gợi ý sản phẩm đầu tiên
            Product p = products.get(0);
            return String.format(
                "Sản phẩm được gợi ý hôm nay là Áo đấu %s, giá %.0f ₫. Tồn kho còn %d. (Chatbot đang ở chế độ giả lập)",
                p.getProductName(), p.getPrice(), p.getStockQuantity()
            );
            
        } else {
            return "Chế độ giả lập đã bật. Giao diện và kết nối server hoạt động tốt! Hãy hỏi tôi về 'trận đấu' hoặc 'sản phẩm' để xem dữ liệu thật.";
        }
    }
    // =========================================================================
    // HÀM GỌI API THẬT (GIỮ NGUYÊN)
    // =========================================================================
    private String getOpenAIResponse(String systemPrompt, String userQuery) throws IOException, InterruptedException {
        // ... (Code gọi API của OpenAI - giữ nguyên)
        List<OpenAIMessage> messages = new ArrayList<>();
        messages.add(new OpenAIMessage("system", systemPrompt)); 
        messages.add(new OpenAIMessage("user", userQuery)); 

        OpenAIRequest requestBody = new OpenAIRequest("gpt-3.5-turbo", messages);
        String jsonBody = gson.toJson(requestBody);

        HttpRequest requestHttp = HttpRequest.newBuilder()
                .uri(URI.create(OPENAI_API_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + OPENAI_API_KEY)
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();

        HttpResponse<String> responseHttp = httpClient.send(requestHttp, BodyHandlers.ofString());

        if (responseHttp.statusCode() != 200) {
            return "Lỗi từ API: " + responseHttp.body();
        }

        OpenAIResponse openAIResponse = gson.fromJson(responseHttp.body(), OpenAIResponse.class);
        
        if (openAIResponse.choices != null && !openAIResponse.choices.isEmpty()) {
            return openAIResponse.choices.get(0).message.content;
        }

        return "Không nhận được câu trả lời từ AI.";
    }

    private String buildSystemPrompt(String userQuery) throws SQLException {
        StringBuilder promptBuilder = new StringBuilder();
        promptBuilder.append("Bạn là trợ lý AI cho trang web fan hâm mộ FC Bayern Munich. ");

        if (userQuery.contains("trận đấu") || userQuery.contains("phân tích")) {
            List<Match> matches = matchDAO.getAllMatchesWithTeamNames();
            promptBuilder.append("Dựa vào dữ liệu Lịch sử trận đấu này: ");
            for (Match m : matches) {
                promptBuilder.append(String.format(
                    "[Ngày: %s, Sân: %s, %s (Tỷ số: %d) vs %s (Tỷ số: %d)], ",
                    m.getMatchDate(), m.getStadium(), m.getHomeTeamName(), m.getHomeScore(),
                    m.getAwayTeamName(), m.getAwayScore()
                ));
            }
        } else if (userQuery.contains("sản phẩm") || userQuery.contains("áo đấu") || userQuery.contains("mua sắm")) {
            List<Product> products = productDAO.getAllProducts();
            promptBuilder.append("Dựa vào danh sách Sản phẩm trong shop này: ");
            for (Product p : products) {
                promptBuilder.append(String.format(
                    "[Tên: %s, Giá: %.0f, Tồn kho: %d, Danh mục: %s], ",
                    p.getProductName(), p.getPrice(), p.getStockQuantity(), p.getCategory()
                ));
            }
        }
        return promptBuilder.toString();
    }
    
    // --- Các lớp Java nhỏ để Gson tự động parse JSON ---
    
    class OpenAIRequest {
        String model;
        List<OpenAIMessage> messages;
        OpenAIRequest(String model, List<OpenAIMessage> messages) {
            this.model = model;
            this.messages = messages;
        }
    }
    
    class OpenAIMessage {
        String role;
        String content;
        OpenAIMessage(String role, String content) {
            this.role = role;
            this.content = content;
        }
    }

    class OpenAIResponse {
        @SerializedName("choices")
        List<Choice> choices;
    }

    class Choice {
        @SerializedName("message")
        OpenAIMessage message;
    }
    // ----------------------------------------------------
}