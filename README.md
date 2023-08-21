# TimeSeriesForecasting
Imputation Methods for Continuous Missing Values and LSTM Multivariate Forecasting in Time Series Data of Traffic Flow

**PHƯƠNG PHÁP ĐIỀN CÁC GIÁ TRỊ KHUYẾT LIÊN TỤC VÀ MÔ HÌNH LSTM DỰ BÁO ĐA BIẾN TRONG DỮ LIỆU TIME SERIES VỀ LƯU LƯỢNG GIAO THÔNG**

## 1. GIỚI THIỆU
Đồ án có hai mục tiêu chính là nghiên cứu một số phương pháp điền khuyết đối với chuỗi thời gian bị thiếu một số lượng lớn dữ liệu trong một khoảng thời gian liên tục và nghiên cứu khả năng dự đoán của mô hình Long – Short Time Memory (LSTM) trên chuỗi thời gian đa biến. Nhóm sử dụng ngôn ngữ lập trình Python trên Google Colab và R trên RStudio để thực hiện đồ án. Dữ liệu lưu lượng giao thông từ các bộ đếm được đặt tại 4 trạm khác nhau và dữ liệu thời tiết tại khu vực đó được thu thập để phục vụ cho bài toán. 
Bằng việc thử nghiệm nhiều thuật toán, phương pháp điền khuyết khác nhau và tiến hành so sánh đánh giá, nhóm tìm ra được phương pháp Dynamic Time Wrapping – Based – Imputation (DTWBI) có thể điền khuyết một cách hiệu quả chuỗi thiếu một số lượng lớn dữ liệu. Nhóm cũng thành công áp dụng mô hình Long – Short Time Memory dự đoán lượng xe tại các trạm giao thông dựa trên lượng xe đi qua các trạm trong vòng 24 giờ trước đó. Sai số RMSE trung bình thu được là 543. 

## 2. NỘI DUNG

