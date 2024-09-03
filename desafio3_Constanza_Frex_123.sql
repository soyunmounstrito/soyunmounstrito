/*
1.Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo pedido.
*/

-- Crear base de datos
CREATE DATABASE desafio3_Constanza_Frex_123;

-- Usar la base de datos creada
\c desafio3_Constanza_Frex_123;

-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id PRIMARY KEY,
    email VARCHAR(50),
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    rol VARCHAR
);

-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (id, email, nombre, apellido, rol) VALUES
	(1, 'admin@example.com', 'Admin', 'Uno', 'administrador'),
	(2, 'user1@example.com', 'User1', 'Dos', 'usuario'),
	(3, 'user2@example.com', 'User2', 'Tres', 'usuario'),
	(4, 'user3@example.com', 'User3', 'Cuatro', 'usuario'),
	(5, 'user4@example.com', 'User4', 'Cinco', 'usuario');
    
-- Revision tabla usuarios
SELECT * from usuarios;

-- Crear tabla de posts
CREATE TABLE posts (
    id PRIMARY KEY,
    titulo VARCHAR(50),
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    fecha_actualizacion TIMESTAMP,
    destacado BOOLEAN,
    usuario_id BIGINT REFERENCES usuarios(id)
);

-- Insertar datos en la tabla posts
INSERT INTO posts (id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES
	(1, 'Post 1', 'Contenido 1', '2024-01-01', '2024-04-03 02:01:00', TRUE, 1),
	(2, 'Post 2', 'Contenido 2', '2024-02-02', '2024-05-04 03:02:01', TRUE, 1),
	(3, 'Post 3', 'Contenido 3', '2024-03-03', '2024-06-05 04:03:02', FALSE, 2),
	(4, 'Post 4', 'Contenido 4', '2024-04-04', '2024-07-06 05:04:03', FALSE, 3),
	(5, 'Post 5', 'Contenido 5', '2024-05-05', '2024-08-07 06:05:04', FALSE, NULL);

-- Revision datos tabla posts
select * FROM posts;

-- Crear tabla de comentarios
CREATE TABLE comentarios (
    id PRIMARY KEY,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    usuario_id BIGINT REFERENCES usuarios(id),
    post_id BIGINT REFERENCES posts(id)
);

-- Insertar datos en la tabla comentarios
INSERT INTO comentarios (id, contenido, fecha_creacion, usuario_id, post_id) VALUES
	(1, 'Comentario 1', '2024-09-01 14:00:00', 1, 1),
	(2, 'Comentario 2', '2024-09-01 15:00:00', 2, 1),
	(3, 'Comentario 3', '2024-09-01 16:00:00', 3, 1),
	(4, 'Comentario 4', '2024-09-02 14:00:00', 1, 2),
	(5, 'Comentario 5', '2024-09-02 15:00:00', 2, 2);

-- Revision contenido tabla comentarios
SELECT * FROM comentarios;

/*
2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
nombre y email del usuario junto al título y contenido del post.
*/

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido FROM usuarios
	INNER JOIN posts ON usuarios.id = posts.usuario_id;

/*
3. Muestra el id, título y contenido de los posts de los administradores.
El administrador puede ser cualquier id
*/
SELECT posts.id, posts.titulo, posts.contenido
FROM posts
INNER JOIN usuarios ON posts.usuario_id = usuarios.id
WHERE usuarios.rol = 'administrador';

/*
4. Cuenta la cantidad de posts de cada usuario.
La tabla resultante debe mostrar el id e email del usuario junto con la cantidad de posts de cada usuario.
*/
SELECT usuarios.id, usuarios.email, COUNT(posts.id) AS cantidad_posts FROM usuarios
	LEFT JOIN posts ON usuarios.id = posts.usuario_id
	GROUP BY usuarios.id, usuarios.email;

/*
5. Muestra el email del usuario que ha creado más posts.
Aquí la tabla resultante tiene un único registro y muestra solo el email.
*/
SELECT usuarios.email FROM usuarios
	INNER JOIN posts ON usuarios.id = posts.usuario_id
	GROUP BY usuarios.email
	ORDER BY COUNT(posts.id) DESC
	LIMIT 1;

/*
6. Muestra la fecha del último post de cada usuario.
*/
SELECT usuarios.nombre, usuarios.email, MAX(posts.fecha_actualizacion) AS ultima_actualizacion FROM usuarios
	INNER JOIN posts ON usuarios.id = posts.usuario_id
	GROUP BY usuarios.nombre, usuarios.email;

/*
7. Muestra el título y contenido del post con más comentarios.
*/
SELECT posts.titulo, posts.contenido FROM posts
	INNER JOIN comentarios ON posts.id = comentarios.post_id
	GROUP BY posts.id
	ORDER BY COUNT(comentarios.id) DESC
	LIMIT 1;

/*
8. Muestra en una tabla el título de cada post, 
el contenido de cada post y el contenido de cada comentario asociado a los posts, 
junto con el email del usuario que lo escribió.
*/
SELECT posts.titulo, posts.contenido AS contenido_post, 
	comentarios.contenido AS contenido_comentario, 
    usuarios.email FROM posts
	INNER JOIN comentarios ON posts.id = comentarios.post_id
	INNER JOIN usuarios ON comentarios.usuario_id = usuarios.id;

/*
9. Muestra el contenido del último comentario de cada usuario.
*/
SELECT usuarios.nombre, usuarios.email, MAX(comentarios.fecha_creacion) AS fecha_ultimo_comentario, 
	comentarios.contenido FROM usuarios
	INNER JOIN comentarios ON usuarios.id = comentarios.usuario_id
	GROUP BY usuarios.nombre, usuarios.email, comentarios.contenido;

/*
10. Muestra los emails de los usuarios que no han escrito ningún comentario.
*/
SELECT usuarios.email FROM usuarios
	LEFT JOIN comentarios ON usuarios.id = comentarios.usuario_id
	GROUP BY usuarios.email
	HAVING COUNT(comentarios.id) = 0;
