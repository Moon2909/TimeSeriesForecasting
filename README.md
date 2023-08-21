# TimeSeriesForecasting
**PHƯƠNG PHÁP ĐIỀN CÁC GIÁ TRỊ KHUYẾT LIÊN TỤC VÀ MÔ HÌNH LSTM DỰ BÁO ĐA BIẾN TRONG DỮ LIỆU TIME SERIES VỀ LƯU LƯỢNG GIAO THÔNG**

***Imputation Methods for Continuous Missing Values and LSTM Multivariate Forecasting in Time Series Data of Traffic Flow***


Nguyen Thi Hoang Anh†, Nguyen Ha Dung†, Ho Thanh Duy Khanh† and Nguyen Thi Nguyet†

**†** VNUHCM - University of Information Technology, Viet Nam.

Contributing authors: [20520134, 20520165, 20521445, 20521689]@gm.uit.edu.vn


## 1. GIỚI THIỆU
Đồ án có hai mục tiêu chính là nghiên cứu một số phương pháp điền khuyết đối với chuỗi thời gian bị thiếu một số lượng lớn dữ liệu trong một khoảng thời gian liên tục và nghiên cứu khả năng dự đoán của mô hình Long – Short Time Memory (LSTM) trên chuỗi thời gian đa biến. Nhóm sử dụng ngôn ngữ lập trình Python trên Google Colab và R trên RStudio để thực hiện đồ án. Dữ liệu lưu lượng giao thông từ các bộ đếm được đặt tại 4 trạm khác nhau và dữ liệu thời tiết tại khu vực đó được thu thập để phục vụ cho bài toán. 

Bằng việc thử nghiệm nhiều thuật toán, phương pháp điền khuyết khác nhau và tiến hành so sánh đánh giá, nhóm tìm ra được phương pháp Dynamic Time Wrapping – Based – Imputation (DTWBI) có thể điền khuyết một cách hiệu quả chuỗi thiếu một số lượng lớn dữ liệu. Nhóm cũng thành công áp dụng mô hình Long – Short Time Memory dự đoán lượng xe tại các trạm giao thông dựa trên lượng xe đi qua các trạm trong vòng 24 giờ trước đó. Sai số RMSE trung bình thu được là 543. 

## 2. NỘI DUNG
***Hình 1. Quy trình thực hiện đồ án***
![Pipline](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/Pipline.png)

### 2.1. Bộ dữ liệu
#### 2.1.1. Phương pháp thu thập
- **Dữ liệu giao thông**

Trang web [dữ liệu giao thông TII](https://trafficdata.tii.ie/publicmultinodemap.asp?fbclid=IwAR2yUbB2XBLOazQCXeNtFcCGJjWM3l7r1DqrG_pXHTqeuN-gKTf_8050aEk) trình bày dữ liệu được thu thập từ các trạm giao thông nằm trên mạng lưới đường bộ ở Ireland. Trang web cho phép người dùng truy cập dữ liệu ở nhiều định dạng báo cáo, biểu đồ và xuất dữ liệu.

Bộ dữ liệu thu thập sẽ bao gồm dữ liệu lưu lượng giao thông tại 4 trạm trên 1 tuyến đường. Nhóm xuất báo cáo loại “Multi-Day Class by Direction” theo từng tháng với mỗi trạm. Số lượng file dữ liệu thô tải về từ website là 48, tương ứng với 12 tháng ở mỗi trạm. File dữ liệu tải về ở định dạng .xlsx.

***Hình 2. Các bước lấy dữ liệu.***
![StepCollectionData](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/CollectionData.png)

- **Dữ liệu thời tiết**

[Trang web Met Éireann - Cơ quan Khí tượng Quốc gia Ireland](https://www.met.ie/climate/available-data/historical-data) cho phép tải dữ liệu thời tiết lịch sử đã được ghi nhận. Nhóm tải bộ dữ liệu thời tiết theo giờ tại trạm Phoenix Park, là trạm có vị trí gần nhất đối với các trạm giao thông phía trên.

#### 2.1.2. Mô tả bộ dữ liệu

Bộ dữ liệu sử dụng bao gồm dữ liệu giao thông và dữ liệu thời tiết được thu thập mỗi giờ từ 1/1/2020 đến ngày 31/12/2020, với station1 đến station4 thể hiện vị trí bộ đếm giao thông và weather thể hiện trạm thời tiết. Trước khi có bộ dữ liệu hoàn chỉnh cho bước phân tích thăm dò, nhóm thực hiện một số bước xử lý dữ liệu thô. Đối với dữ liệu giao thông ở mỗi trạm, tiến hành tách và gộp các bảng và thuộc tính cần thiết. 

Đối với dữ liệu thời tiết, file tải về từ website bao gồm dữ liệu từ năm 2003 đến nay, cho đó cần trích xuất ra dữ liệu của năm 2020. Cột ‘Weekday’ và ‘Month’ được thêm vào bộ dữ liệu giao thông và thời tiết để thuận tiện cho việc phân tích và trực quan dữ liệu theo các mốc thời gian khác nhau. 
Tiếp đến, nhóm tiến hành chuyển đổi kiểu dữ liệu sang kiểu mong muốn và điền thiếu dữ liệu giao thông. Dữ liệu giao thông chỉ bị thiếu một vài điểm rời rạc ở mỗi station, do đó nhóm sử dụng giá trị trung bình của lưu lượng xe tại thời điểm t – 1 và t + 1 để điền thiếu tại thời điểm t. Cuối cùng, các bộ dữ liệu hoàn chỉnh có kích thước là (70272, 14) đối với station1, station2, station3; (79056, 14) đối với station4 và (8784, 11) đối với bộ dữ liệu thời tiết. 

***Hình 3. Vị trí các trạm của bộ dữ liệu.***
![LocationData](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/LocationData.png)

***Bảng 1. Mô tả thuộc tính bộ dữ liệu giao thông***
![StationData](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/StationData.png)

***Bảng 2. Mô tả thuộc tính bộ dữ liệu thời tiết***
![WeatherData](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/WeatherData.png)


### 2.2. Phân tích thăm dò (EDA)
#### 2.2.1. Tính xu hướng (Trend)
#### 2.2.2. Tính mùa vụ
#### 2.2.3. Mối quan hệ giữa các thuộc tính

Mối tương quan giữa các thuộc tính của bộ dữ liệu được thể hiện ở mục Phụ lục. Xét mối quan hệ giữa lượng giao thông đi qua mỗi trạm, các thuộc tính này có mối tương quan rất mạnh (độ tương quan > 0.9). Có nghĩa là tính chất của chuỗi lưu lượng xe tại các trạm có nhiều nét tương đồng nhau. Điều này là dễ hiểu vì các bộ đếm giao thông được đặt liên tiếp nhau trên cùng một tuyến đường. 

Xét mối quan hệ giữa các yếu tố thời tiết, ta quan sát được các thuộc tính nhiệt độ không khí (temp), nhiệt độ bầu ướt (wetb), nhiệt độ điểm sương (dewpt) và áp suất hơi nước (vappr) có ảnh hưởng đối với nhau theo mối tương quan đồng thuận (độ tương quan > 0.9).

Xét mối quan hệ giữa lượng xe và các yếu tố thời tiết, chỉ có thuộc tính độ ẩm (rhum) có tương quan thấp với lưu lượng giao thông (độ tương quan dao động trong khoảng 0.34 - 0.39 < 0.5). Các thuộc tính thời tiết khác đa phần không ảnh hưởng đến lưu lượng giao thông tại các trạm. 

### 2.3. Điền khuyết
#### 2.3.1. Các phương pháp điền khuyết

Thực tế, ta không thể đánh giá được độ hiệu quả của các phương pháp điền khuyết trên bộ dữ liệu thiếu trong thực tế vì không có giá trị đúng để đối chiếu so sánh. Do đó, các phương pháp sẽ được tiến hành trên bộ dữ liệu mô phỏng, đã được xóa đi những khoảng khuyết liên tục có kích thước (1 tuần, 1 tháng, 2 tháng) và vị trí khác nhau để đảm bảo tính ngẫu nhiên của dữ liệu. Có hai phương pháp cơ bản để xử lí các giá trị khuyết là bỏ qua các giá trị bị thiếu và thay thế các giá trị bị thiếu. Nếu bỏ đi các giá trị bị khuyết, đặc biệt là khuyết với khoảng lớn, chuỗi thời gian sẽ bị đứt đoạn và có thể mất đi một số đặc tính quan trọng. Vì vậy, nhóm chỉ tập trung nghiên cứu nhóm phương pháp điền giá trị thiếu. 

***Bảng 3. Mô tả các khoảng giá trị làm khuyết***
![DataGap](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/DataGap.png)

**- Sử dụng mô hình Random Forests với phương pháp lặp MICE (Multiple Imputation by Chained Equations)**

Phương pháp sử dụng thư viện miceforest, với cơ chế sử dụng LightGBM trong một phương pháp lặp được gọi là MICE.
***Hình 9. Cơ chế hoạt động thuật toán MICE***
![MICE](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/MICE_Algorithm.png)

- **Phương pháp Seasonal Moving Window Average (SMWA)**

SMWA là phương pháp kết hợp giữa nội suy tuyến tính và trung bình trượt. Cụ thể hơn, trước khi điền thiếu, chuỗi thời gian được phân rã thành các thành phần xu hướng, mùa vụ và phần dư. Chuỗi xu hướng là một chuỗi đơn giản chỉ có tính tăng hoặc giảm nên ta áp dụng phương pháp nội suy tuyến tính để điền thiếu chuỗi này. Đối với chuỗi mùa vụ và phần dư thì có cấu trúc phức tạp hơn, vì thế kĩ thuật trung bình trượt được áp dụng đối với chuỗi này. Sau khi sử dụng 2 phương pháp khác nhau để điền thiếu các thành phần được phân rã, ta gộp các thành phần này lại thành một chuỗi hoàn thiện đã được điền khuyết.

- **Phương pháp Seasonal Moving Window Average (SMWA)**

Phương pháp DTWBI cho phép điền chuỗi thời gian đơn biến với số lượng lớn dữ liệu bị thiếu. Đặt t_gap là vị trí bắt đầu đoạn thiếu và T_gap là kích thước của đoạn. Thuật toán tạo ra cửa sổ trượt ngay sau đoạn thiếu (Qa) nếu t_gap nằm ở nửa đầu chuỗi thời gian, ngược lại thì cửa sổ trượt được tạo ngay trước đoạn thiếu (Qb). Cửa sổ Qa và Qb có kích thước bằng T_gap. Sau đó, thuật toán tìm ra cửa sổ tương tự nhất với Qa và Qb bằng cách trượt cửa sổ tới hai đầu mút của chuỗi. Cửa số giống với Qa hoặc Qb nhất sẽ được điền vào khoảng trống. 

#### 2.3.2. Đánh giá các phương pháp
***Bảng 4. Bảng độ đo của các phương pháp điền khuyết dữ liệu***
![Result](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/Result.png)

Để đánh giá hiệu quả điền khuyết của 3 phương pháp nêu trên, ta so sánh giá trị của 3 độ đo tương tự (Similarity), FSD và RMSE so với một số phương pháp điền khuyết truyền thống khác như nội suy tuyến tính, trung bình trượt, … Trong đó, độ tương tự càng gần 1 thì chứng tỏ phương pháp càng có khả năng ước lượng giá trị thiếu; giá trị FSD càng gần 0 thì giá trị điền càng gần với giá trị thực; độ đo RMSE đánh giá độ chính xác tổng thể của phương pháp, RMSE càng thấp thì phương pháp điền thiếu càng hiệu quả. 

Từ Bảng 4, phương pháp DTWBI có hiệu quả vượt trội so với những phương pháp khác. DTWBI là phương pháp điền khuyết tốt nhất trên chuỗi dữ liệu bị thiếu 1 tuần và 1 tháng và cũng dự đoán khá tốt trên bộ dữ liệu bị thiếu 2 tháng. Phương pháp SMWA và MICE không có hiệu quả nổi bật so với các phương pháp truyền thống. 

### 2.4. Xây dựng mô hình Long-Short Term Memory (LSTM)
#### 2.4.1. Chuẩn bị dữ liệu

Khi sử dụng mô hình LSTM để dự đoán lưu lượng giao thông, bài toán được quy về dạng học có giám sát, cụ thể là, dự đoán số lượng xe tại một trạm giao thông ở thời điểm t dựa trên lưu lượng xe tại cả 4 trạm ở các bước thời gian trước đó. Vậy nên bước đầu tiên chuẩn bị dữ liệu cho việc huấn luyện mô hình là chuẩn hóa dữ liệu sử dụng phương pháp scale min_max. Tiếp đến ta tiến hành biến đổi bảng dữ liệu cho phù hợp với dạng học có giám sát, chia tập huấn luyện và kiểm thử như Hình 9. Cuối cùng, đầu vào (X) được biến đổi thành tập dữ liệu 3 chiều theo yêu cầu của mô hình LSTM: (samples, timesteps, features). 

***Hình 10. Lược đồ thể hiện cách biến đổi dữ liệu và chia tập huấn luyện – kiểm thử***
![SplitData](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/SplitData.png)


#### 2.4.2. Xây dựng mô hình dự đoán lưu lượng giao thông

Mô hình LSTM được xây dựng có 50 neurons ở hidden layer đầu tiên và 1 neuron ở lớp đầu ra nhằm dự đoán số lượng xe một bộ đếm ghi nhận được. Kích thước đầu vào là (độ trễ, 4). Nhóm sử dụng hàm mất mát MAE và hàm tối ưu Adam. Mô hình được huấn luyện với 50 epochs và batch size là 72.

#### 2.4.3. Kết quả dự đoán

Huấn luyện mô hình với các độ trễ 3 giờ, 24 giờ (1 ngày) và 168 giờ (1 tuần), dự đoán lưu lượng xe lần lượt tại 4 trạm giao thông. Theo Bảng 4, kết quả nhận được là đối với độ trễ càng lớn thì độ chính xác mô hình LSTM đạt được càng cao, đồng thời, thời gian huấn luyện mô hình càng lâu. Mô hình LSTM với độ trễ 24 giờ vừa đảm bảo lượng xe được dự đoán có độ chính xác cao và không mất quá nhiều thời gian để huấn luyện.

***Bảng 5. Độ đo RMSE của mô hình LSTM dự đoán lượng xe trong tháng 12/2020 tại các trạm giao thông với các độ trễ khác nhau.***
![Delay](https://github.com/Moon2909/TimeSeriesForecasting/blob/main/Picture/Delay.png)


## 3. KẾT LUẬN

Nhóm đã giải quyết được hai mục tiêu chính của đồ án là nghiên cứu phương pháp điền khuyết đối với chuỗi dữ liệu thiếu liên tục và sử dụng mô hình dự đoán chuỗi thời gian đa biến. Trong ba phương pháp điền khuyết được nghiên cứu trọng tâm, phương pháp DTWBI có khả năng điền thiếu vượt trội trên 2 bộ dữ liệu thiếu 1 tuần, 1 tháng và điền thiếu khá tốt đối với dữ liệu thiếu 2 tháng. Điều này cho thấy phong độ ổn định của phương pháp DTWBI khi áp dụng trên chuỗi thời gian có tính mùa vụ với các kích thước và vị trí thiếu dữ liệu khác nhau. 

Bên cạnh đó, nhóm tiến hành dự đoán lượng xe mỗi giờ trong tháng 12/2020 sử dụng mô hình LSTM. Mô hình sử dụng lượng xe tại 4 trạm trong vòng 3 giờ, 24 giờ và 168 giờ trước đó để dự đoán lượng xe cho thời điểm hiện tại. Tuy mô hình với độ trễ 168 giờ cho ra kết quả dự đoán tốt nhất nhưng lại tốn nhiều thời gian để huấn luyện. Vì thế, nhóm kết luận có thể sử dụng mô hình LSTM với độ trễ 24 giờ, vừa đảm bảo được độ chính xác cao, vừa tiết kiệm được chi phí huấn luyện mô hình. 
