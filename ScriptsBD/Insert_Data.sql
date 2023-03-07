use Proyecto
Go
-- Insert RolUsiuario
INSERT INTO RolUsuario (Codigo, Descripcion)
VALUES ('ADMIN', 'Administrador'),
('USER', 'Usuario');
               
-- Insert Usuario   
INSERT INTO Usuario (Nombres, Apellidos, FechaNacimiento, Email, Contrasena, Rol, Estado, CreatedAt, UpdateAt)
VALUES ('Ivonne', 'Minchala', '1998-12-25', 'Ivonne@example.com', '1234', 'USER', 'activo', GETDATE(), null),
('Keneth', 'Riera', '2000-12-02', 'Keneth@example.com', '1234', 'USER', 'activo', GETDATE(), null),
('Danilo', 'Pin', '1999-05-28 ', 'Danilo@example.com', '1234', 'USER', 'activo', GETDATE(), null),
('Melany', 'Mero', '1998-10-08', 'Melany@example.com', '1234', 'USER', 'activo', GETDATE(), null),
('Carlos', 'Bone', '1996-04-09', 'Carlos@example.com', '1234', 'USER', 'activo', GETDATE(), null),
('Bryan', 'Rizzo', '1999-07-30 ', 'Bryan@example.com', '1234', 'USER', 'activo', GETDATE(), null),
('Roxana', 'Veloz', '1997-01-29', 'Roxana@example.com', '1234', 'ADMIN', 'activo', GETDATE(), null),
('Jorge', 'Charco', '1986-08-19', 'Jorge@example.com', '1234', 'ADMIN', 'activo', GETDATE(), null);

-- Insert Forma de Pago
INSERT INTO FormaPago (Codigo, Metodo)
VALUES ('EFE', 'Efectivo'),
('DEB', 'Debito'),
('PAY', 'PayPal'),
('CRED', 'Credito');

-- Insert Forma de Pago del Usuario 
INSERT INTO FormaPago_Usuario (Usuario, FormaPago, Cuenta, CreatedAt)
VALUES (1, 'PAY','payIvonne@Example', GETDATE()),
(2, 'EFE',null, GETDATE()),
(3, 'CRED','14563269854789652', GETDATE()),
(4, 'DEB','12225698933654788', GETDATE()),
(5, 'CRED','1477889633654526', GETDATE()),
(6, 'EFE',null, GETDATE());

-- Insert categorias de Producto
INSERT INTO CategoriaProducto (Codigo, Descripcion)
VALUES ('BEBC', 'Bebida caliente'),
('BEBF', 'Bebida  fr�a'),
('Pos', 'Postre'),
('SAN', 'S�ndwiches');

-- Insert productos
INSERT INTO Producto (Nombre, Descripcion, ImagenUrl, Precio, Categoria, Estado, CreatedAt, UpdatedAt)
VALUES ('Capuchino', 'caf� espresso originaria de Italia', 'https://images.unsplash.com/photo-1534778101976-62847782c213?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 5.99, 'BEBC', 'activo', GETDATE(), null),
('Milkshake', 'bebida espesa y cremosa hecha a base de helado batido con leche ', 'https://www.yourhomebasedmom.com/wp-content/uploads/2021/08/CHOCOLATE-MILK-SHAKE-5520.jpg',4.50, 'BEBF', 'activo', GETDATE(), null),
('Cupcakes', 'peque�o pastel individual', 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 2.15, 'Pos', 'activo', GETDATE(), null),
('frapp�s', 'bebida helada y espumosa hecha con hielo triturado, caf� expreso', 'https://img1.wsimg.com/isteam/ip/7b7b9caf-6f41-421f-ab42-97d07f7f833d/eiliv-sonas-aceron-44d0W8JhoPc-unsplash-0001.jpg/:/cr=t:17.53%25,l:17.53%25,w:64.94%25,h:64.94%25', 5.50, 'BEBF ', 'activo', GETDATE(), null),
('s�ndwiches de jam�n y queso', 'Dos rebanadas de pan con jam�n y queso en el interior y Tostado', 'https://okdiario.com/img/2019/01/21/receta-de-sandwinch-de-jamon-y-queso-con-mostaza.jpg', 1.25, 'SAN', 'activo', GETDATE(), null),
('Expreso', 'Dos rebanadas de pan con jam�n y queso en el interior y Tostado', 'https://okdiario.com/img/2019/01/21/receta-de-sandwinch-de-jamon-y-queso-con-mostaza.jpg', 3.90, 'BEBC', 'activo', GETDATE(), null);

-- insert Compra por Unidad 
INSERT INTO CompraUnidad (Usuario, FormaPago_Usuario, Producto, Cantidad)
VALUES (1, 11, 3, 2),
(2, 12, 4, 1),
(3, 13, 5, 4),
(4, 14, 6, 3),
(5, 15, 7, 2),
(6, 16, 8, 3);

-- Create purchase bundles
INSERT INTO CompraConjunto (CompraUnidad)
VALUES (6),
(7),
(8),
(9),
(10),
(11);






