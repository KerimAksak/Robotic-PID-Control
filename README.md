# Robotic-PID-Control

Simülasyon ortamında bulunan araca verilen açıyı PID ile kontrol edilip ve differential drive'a göre hareket ettirilmesi.


## Genel Detaylar
1. Matlab ortamında iki boyutta hareket eden 
robotun açı kontrolü yapılacaktır. Robot “differential-drive” tipinde 2
tekerlekli bir robottur. Üzerinde yönünü algılayan bir pusula ve
tekerleklerinde uygulanan DC gerilimi ölçen sensörler bulunmaktadır.
Robotu Matlab ortamında kullanabilmek için Robotics Playground
eklentisinin yüklenmiş olması gereklidir. Detaylı bilgiye
[roboticsplayground](https://www.mathworks.com/matlabcentral/fileexchange/67157-roboticsplayground)
adresinden ulaşılabilir.

Robotun kontrolü kabaca şu şekilde anlatılabilir:

• Her tekerleğe -5V ve 5V arasında bir gerilim uygulanır.

• Tekerlek hızı uygulanan gerilimle doğru orantılıdır.

• Tekerleklerin hızları ile robotun hangi yönde hangi hızla gideceği
hesaplanabilir.

2.  Kontrolcü olarak PID kontrolör kullanılacaktır.
PID katsayıları dosya üzerinden değiştirilebilecektir. Simülasyon başlatılmadan önce robotun dönmesi
istenen açı, doğrusal ve PID katsayıları girilmelidir. Simülasyon sonlandırıldığında simülasyonla ilgili 6 adet grafik istenmektedir.
Bunlar: Açı[rad], Tekerlek Açısal Hızları[rad/s], vLeft[volt], vRight[volt], Hata[rad], Kontrol Sinyali(u). 

##### NOT : Simülasyon için hazırlanmış fonksiyonlara Robotics Playground’un web sayfasından [roboticsplayground](https://github.com/mathworks-robotics/robotics-playground) ulaşabilirsiniz.

# ➤ Proje içinden görüntüler

![alt text](https://raw.githubusercontent.com/KerimAksak/Robotic-PID-Control/master/vehicle_1.jpg)

![alt text](https://raw.githubusercontent.com/KerimAksak/Robotic-PID-Control/master/vehicle_2jpg.jpg)

![alt text](https://raw.githubusercontent.com/KerimAksak/Robotic-PID-Control/master/vehicle_3.jpg)

