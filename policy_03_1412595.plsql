-- Trưởng phòng update soNhanVien của phòng ban mình quản lý
CREATE OR REPLACE PROCEDURE tp_phongban_update(p_truongPhong char, p_soNhanVien int)
IS
BEGIN
       UPDATE PHONGBAN
       SET soNhanVien = p_soNhanVien
       WHERE p_truongPhong = TruongPhong;
END tp_phongban_update;
/

-- Cấp quyền thực thi procedure tp_phongban_update cho trưởng phòng
GRANT EXECUTE ON tp_phongban_update to TruongPhong;

begin
  -- Call the procedure
  tp_phongban_update(p_truongphong => :p_truongphong,
                     p_sonhanvien => :p_sonhanvien);
end;


-- Trưởng chi nhánh update phòng ban thuộc chi nhánh mình quản lý
CREATE OR REPLACE PROCEDURE tcn_phongban_update(p_truongChiNhanh char, p_maPhong char,
                                                p_tenPhong nvarchar2, p_truongPhong char,
                                                p_ngayNhanChuc date, p_soNhanVien int)
IS
BEGIN
       UPDATE PHONGBAN
       SET tenPhong = p_tenPhong, truongPhong = p_truongPhong,
           ngayNhanChuc = p_ngayNhanChuc, soNhanVien = p_soNhanVien 
       WHERE p_maPhong = maPhong and p_truongChiNhanh in (select cn.truongChiNhanh
                                                          from CHINHANH cn, PHONGBAN pb
                                                          where p_maPhong = pb.maPhong and pb.chiNhanh = cn.maCN);
END tcn_phongban_update;
/

-- Cấp quyền thực thi procedure tcn_phongban_update cho trưởng chi nhánh
GRANT EXECUTE ON tcn_phongban_update to TruongChiNhanh;

begin
  -- Call the procedure
  tcn_phongban_update(p_truongchinhanh => :p_truongchinhanh,
                      p_maphong => :p_maphong,
                      p_tenphong => :p_tenphong,
                      p_truongphong => :p_truongphong,
                      p_ngaynhanchuc => :p_ngaynhanchuc,
                      p_sonhanvien => :p_sonhanvien);
end;
