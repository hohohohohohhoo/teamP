CREATE TABLE tbl_member(
id VARCHAR2(6),
pw VARCHAR2(600),
name VARCHAR2(15),
birth DATE,
CONSTRAINT pk_member_id primary KEY(id)
)

SELECT * FROM tbl_member

DELETE FROM tbl_member WHERE id = 'm003'