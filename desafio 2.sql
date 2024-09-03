-- tabla clientes
CREATE TABLE clientes(
	email VARCHAR(50),
	nombre VARCHAR,
	telefono VARCHAR(16),
	empresa VARCHAR(50),
	prioridad SMALLINT
);

-- ingreso datos a tabla clientes
INSERT INTO clientes(email, nombre, telefono, empresa, prioridad) VALUES
('aa@aa.cl', 'AA', '0911111111', 'Empresa 1', 10),
('bb@bb.cl', 'BB', '0911111121', 'Empresa 2', 9),
('cc@cc.cl', 'CC', '0911111311', 'Empresa 3', 8),
('dd@dd.cl', 'DD', '0911114111', 'Empresa 4', 7),
('ee@ee.cl', 'EE', '0911151111', 'Empresa 5', 6),
('ff@ff.cl', 'FF', '0911611111', 'Empresa 6', 5),
('gg@gg.cl', 'GG', '0917111111', 'Empresa 7', 4),
('hh@hh.cl', 'HH', '0981111111', 'Empresa 8', 3),
('ii@ii.cl', 'II', '0911111110', 'Empresa 9', 2),
('jj@jj.cl', 'JJ', '1911111111', 'Empresa 10', 1);

-- 3 clientes de mayor prioridad
SELECT * FROM clientes ORDER BY prioridad DESC LIMIT 3;

-- clientes con prioridad mayor a 5
SELECT * FROM clientes WHERE prioridad > 5;
