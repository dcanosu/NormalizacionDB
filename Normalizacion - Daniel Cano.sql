-- 1. Dada la siguiente tabla propuesta por un estudiante:

CREATE TABLE ArtistaCancion (
 IdInterprete INT,
 NombreInterprete NVARCHAR(50),
 IdPais INT,
 Pais NVARCHAR(50),
 IdCancion INT,
 TituloCancion NVARCHAR(50),
 Idiomas NVARCHAR(MAX), -- ejemplo: "Español, Inglés"
 Ritmo NVARCHAR(50),
)

-- a. Indique TODAS las formas normales que esta tabla NO cumple e identifique por qué.

La 1FN indica que los datos deben de ser atómicos por lo cual acá se estaría violando esta norma con el atributo Idiomas dado que este
puede contener varios valores como por ejemplo: Inglés, Español, Francés.

La 2FN requiere que la tabla este en 1FN y que ningún atributo o clave dependa parcialmente de la clave primaria. Acá encontramos unos atributos
no clave como NombreInterprete, IdPais, TituloCancion, Idiomas, Ritmo y un posible llave compuesta entre IdInterprete y Idcancion. 

La 3FN requiere que la tabla este en 2FN y que no existan dependencias transitivas. El atributo no clave Pais depende del atributo no clave IdPais,
el cual depende de la clave parcial IdInterprete. Hay una dependencia entre dos atributos no clave, donde el país puede ser determinado por su ID sin
necesidad de conocer la canción o el intérprete

-- b. Reescriba el conjunto de tablas normalizadas cumpliendo mínimo hasta 3FN.
Para poder cumplir con la 3FN, debemos eliminar el incumplimiento de atomicidad, las dependencias parciales y las dependencias transitivas mediante la descomposición
de la tabla original en varias tablas

CREATE TABLE Interpretacion (
    Id INT PRIMARY KEY,
    IdCancion INT NOT NULL,
    IdInterprete INT NOT NULL,
    Duracion INT,
    IdRitmo INT NOT NULL
);


CREATE TABLE Album (
    Id INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Registro VARCHAR(50),
    IdMedio INT NOT NULL
);


CREATE TABLE Formato (
    Id INT PRIMARY KEY,
    Formato VARCHAR(50)
);

La tabla grabación ya se encuentra normalizada



-- 2. Analice la tabla Grabacion del modelo entregado:
La tabla Grabacion está en BCNF porque su único determinante es la clave primaria compuesta (IdInterpretacion, IdAlbum, IdFormato), y no existen dependencias funcionales
donde un atributo no clave determine a otro. Por lo tanto, todo determinante es clave, cumpliendo la definición de BCNF.

El atributo IdInterpretacion está definido con IDENTITY(1,1). Esto es incorrecto, ya que IdInterpretacion es una clave foránea (FK)



-- 3. En la base de datos, un productor propone una nueva tabla para registrar campañas de promoción:

-- a. Indique si esta tabla viola la 4FN. Justifique usando el concepto de dependencias multivaloradas
Viola la 4FN porque para un mismo IdInterpretacion existen conjuntos multivalorados independientes (por ejemplo: álbumes, formatos, plataformas, países).
Esto genera dependencias multivaloradas del tipo: IdInterpretacion -> IdAlbum | IdInterpretacion -> IdFormato


-- b. Normalice la tabla cumpliendo la 4FN y la 5FN.
Se separan las relaciones multivaloradas en tablas independientes:
CREATE TABLE InterpretacionAlbum (
    IdInterpretacion INT,
    IdAlbum INT,
    PRIMARY KEY (IdInterpretacion, IdAlbum)
);

CREATE TABLE InterpretacionFormato (
    IdInterpretacion INT,
    IdFormato INT,
    PRIMARY KEY (IdInterpretacion, IdFormato)
);

CREATE TABLE InterpretacionPlataforma (
    IdInterpretacion INT,
    IdPlataforma INT,
    PRIMARY KEY (IdInterpretacion, IdPlataforma)
);

CREATE TABLE InterpretacionPais (
    IdInterpretacion INT,
    IdPais INT,
    PRIMARY KEY (IdInterpretacion, IdPais)
);

