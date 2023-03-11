-- Insert RolUsuario
INSERT INTO RolUsuario 
    (Codigo, Descripcion)
VALUES 
    ('ADMIN', 'Administrador'),
    ('USER', 'Usuario');
               
-- Insert Usuario   
INSERT INTO Usuario 
    (Cedula, Nombres, Apellidos, FechaNacimiento, Email, Contrasena, Rol, Estado, CreatedAt, UpdateAt)
VALUES 
    ('11111','Ivonne', 'Minchala', '1998-12-25', 'Ivonne@example.com', '1234', 'USER', 'A', GETDATE(), null),
    ('22222','Keneth', 'Riera', '2000-12-02', 'Keneth@example.com', '1234', 'USER', 'A', GETDATE(), null),
    ('33333','Danilo', 'Pin', '1999-05-28 ', 'Danilo@example.com', '1234', 'USER', 'A', GETDATE(), null),
    ('44444','Melany', 'Mero', '1998-10-08', 'Melany@example.com', '1234', 'USER', 'A', GETDATE(), null),
    ('555555','Carlos', 'Bone', '1996-04-09', 'Carlos@example.com', '1234', 'USER', 'A', GETDATE(), null),
    ('66666','Bryan', 'Rizzo', '1999-07-30 ', 'Bryan@example.com', '1234', 'USER', 'A', GETDATE(), null),
    ('777777','Roxana', 'Veloz', '1997-01-29', 'Roxana@example.com', '1234', 'ADMIN', 'A', GETDATE(), null),
    ('88888','Jorge', 'Charco', '1986-08-19', 'Jorge@example.com', '1234', 'ADMIN', 'A', GETDATE(), null);

-- Insert Forma de Pago
INSERT INTO FormaPago 
    (Codigo, Metodo)
VALUES 
    ('EFE', 'Efectivo'),
    ('DEB', 'Debito'),
    ('PAY', 'PayPal'),
    ('CRED', 'Credito');

-- Insert Forma de Pago del Usuario 
INSERT INTO FormaPago_Usuario 
    (Usuario, FormaPago, Cuenta, CreatedAt)
VALUES 
    (1, 'PAY', 'payIvonne@Example', GETDATE()),
    (2, 'EFE', null, GETDATE()),
    (3, 'CRED', '14563269854789652', GETDATE()),
    (4, 'DEB', '12225698933654788', GETDATE()),
    (5, 'CRED', '1477889633654526', GETDATE()),
    (6, 'EFE', null, GETDATE());

-- Insert categorias de Producto
INSERT INTO CategoriaProducto 
    (Codigo, Descripcion)
VALUES 
    ('BEBC', 'Bebida caliente'),
    ('BEBF', 'Bebida  fría'),
    ('Pos', 'Postre'),
    ('SAN', 'S�ndwiches');

-- Insert productos
INSERT INTO Producto 
    (Nombre, Descripcion, ImagenUrl, Precio, Categoria, Estado, CreatedAt, UpdatedAt)
VALUES 
    ('Capuchino', 'café espresso originaria de Italia', 'https://images.unsplash.com/photo-1534778101976-62847782c213?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 5.99, 'BEBC', 'A', GETDATE(), null),
    ('Milkshake', 'bebida espesa y cremosa hecha a base de helado batido con leche ', 'https://www.yourhomebasedmom.com/wp-content/uploads/2021/08/CHOCOLATE-MILK-SHAKE-5520.jpg',4.50, 'BEBF', 'A', GETDATE(), null),
    ('Cupcakes', 'pequeño pastel individual', 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 2.15, 'Pos', 'A', GETDATE(), null),
    ('frapp�s', 'bebida helada y espumosa hecha con hielo triturado, café expreso', 'https://img1.wsimg.com/isteam/ip/7b7b9caf-6f41-421f-ab42-97d07f7f833d/eiliv-sonas-aceron-44d0W8JhoPc-unsplash-0001.jpg/:/cr=t:17.53%25,l:17.53%25,w:64.94%25,h:64.94%25', 5.50, 'BEBF ', 'A', GETDATE(), null),
    ('s�ndwiches de jamón y queso', 'Dos rebanadas de pan con jamón y queso en el interior y Tostado', 'https://okdiario.com/img/2019/01/21/receta-de-sandwinch-de-jamon-y-queso-con-mostaza.jpg', 1.25, 'SAN', 'A', GETDATE(), null),
    ('Expreso', 'Dos rebanadas de pan con jam�n y queso en el interior y Tostado', 'https://okdiario.com/img/2019/01/21/receta-de-sandwinch-de-jamon-y-queso-con-mostaza.jpg', 3.90, 'BEBC', 'A', GETDATE(), null);

-- insert Compra por Unidad 
INSERT INTO CompraUnidad 
    (Producto, Cantidad)
VALUES 
    (1, 2),
    (2, 1),
    (3, 4),
    (4, 3),
    (5, 2),
    (6, 3);

-- Create purchase bundles
INSERT INTO CompraConjunto 
    (CompraUnidad, FormaPago_Usuario)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);