CREATE VIEW PHONGCHUTRI AS SELECT MAPHONG, TENPHONG, CHINHANH FROM QTV.PHONGBAN WHERE MAPHONG IN (SELECT PHONGCHUTRI 
                                                                                                                                                                                        FROM  QTV.DUAN);
CREATE VIEW CHINHANHCHUTRI AS SELECT MACN, TENCN FROM QTV.CHINHANH WHERE MACN IN (SELECT CN.MACN
                                                                                                                                                                        FROM  QTV.DUAN D, QTV.PHONGBAN P, QTV.CHINHANH CN
                                                                                                                                                                        WHERE D.PHONGCHUTRI = P.MAPHONG AND P.CHINHANH =  CN.MACN);
CREATE VIEW TRUONGDUAN AS SELECT MANV, HOTEN FROM QTV.NHANVIEN WHERE MANV IN (SELECT TRUONGDA
                                                                                                                                                                  FROM QTV.DUAN);
CREATE VIEW TONGCHITIEU AS SELECT SUM(SOTIEN) TONGTIEN, DUAN FROM QTV.CHITIEU
                                                                                                                          GROUP BY(DUAN);
CREATE VIEW TTDUAN AS (SELECT MADA, TENDA, KINHPHI, TENPHONG TENPHONGCHUTRI, TENCN TENCNCHUTRI, HOTEN TENTRUONGDA, TONGTIEN
                                                FROM   QTV.DUAN D, QTV.PHONGCHUTRI P, QTV.TRUONGDUAN TDA, QTV.CHINHANHCHUTRI CN, QTV.TONGCHITIEU TCT                                        
                                                WHERE  D.PHONGCHUTRI = P.MAPHONG AND P.CHINHANH = CN.MACN AND D.TRUONGDA = TDA.MANV AND D.MADA = TCT.DUAN)
   
GRANT SELECT ON QTV.DUAN TO GiamDoc; 
GRANT SELECT ON QTV.PHONGCHUTRI TO GiamDoc; 
GRANT SELECT ON QTV.CHINHANHCHUTRI TO GiamDoc; 
GRANT SELECT ON QTV.TRUONGDUAN TO GiamDoc; 
GRANT SELECT ON QTV.TONGCHITIEU TO GiamDoc;
GRANT SELECT ON QTV.TTDUAN TO GiamDoc;
