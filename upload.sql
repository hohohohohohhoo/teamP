CREATE TABLE tbl_upload(
filename VARCHAR2(300) NOT NULL,
bno NUMBER,
CONSTRAINT fk_upload_bno FOREIGN KEY(bno) REFERENCES tbl_board(bno)
ON DELETE CASCADE
)

select * from tbl_upload

drop table tbl_upload