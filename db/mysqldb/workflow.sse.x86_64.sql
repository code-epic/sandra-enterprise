-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 09-02-2023 a las 17:37:15
-- Versión del servidor: 8.0.31
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `code_epic`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_001_Definicion`
--

CREATE TABLE `WKF_001_Definicion` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idap` int NOT NULL COMMENT 'Id Aplicacion',
  `idmo` int NOT NULL COMMENT 'Id Modulo',
  `nomb` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre del WKF',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT ' Observaciones',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `WKF_001_Definicion`
--

INSERT INTO `WKF_001_Definicion` (`id`, `idap`, `idmo`, `nomb`, `obse`, `fech`) VALUES
(1, 0, 0, 'CORE', 'MIDDLEWARE', '2022-09-07 13:28:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_002_Serie`
--

CREATE TABLE `WKF_002_Serie` (
  `id` int NOT NULL COMMENT 'Identificador',
  `cod` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Codigo para la formula',
  `long` int NOT NULL COMMENT 'Logitud de la serie',
  `fech` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `WKF_002_Serie`
--

INSERT INTO `WKF_002_Serie` (`id`, `cod`, `long`, `fech`, `obse`) VALUES
(1, 'API', 8, '2023-01-20 21:05:12', 'Generacion de Fnx Sandra Server');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_003_Estado`
--

CREATE TABLE `WKF_003_Estado` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idw` int NOT NULL COMMENT 'Id Workflow',
  `nomb` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre del Estado',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_004_Transiciones`
--

CREATE TABLE `WKF_004_Transiciones` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idw` int NOT NULL COMMENT 'Id Workflow',
  `func` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Id Formula',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_005_Red`
--

CREATE TABLE `WKF_005_Red` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idw` int NOT NULL COMMENT 'Identificador Workflow',
  `eo` int NOT NULL COMMENT 'Estado Orgine',
  `tr` int NOT NULL COMMENT 'Conjunto de transiciones',
  `edv` int NOT NULL COMMENT 'Estado Destino verdadero',
  `edf` int NOT NULL COMMENT 'Estado Destino falso',
  `fech` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_006_Documento`
--

CREATE TABLE `WKF_006_Documento` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idw` int NOT NULL COMMENT 'Identificador Workflow',
  `nomb` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre del Documento',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `estado` tinyint(1) NOT NULL COMMENT 'Estado documento',
  `estatus` tinyint(1) NOT NULL COMMENT 'Estatus',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Disparadores `WKF_006_Documento`
--
DELIMITER $$
CREATE TRIGGER `actualizaDocumento` AFTER UPDATE ON `WKF_006_Documento` FOR EACH ROW BEGIN
    INSERT INTO `WKF_012_Traza`(`idd`, `ide`, `obse`, `esta`, `usua`, `fech`) 
    VALUES (OLD.id, OLD.estado, OLD.obse, OLD.estatus, OLD.usua, OLD.fech);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `iniciarDocumentos` AFTER INSERT ON `WKF_006_Documento` FOR EACH ROW BEGIN
    INSERT INTO `WKF_008_Documento_Ubicacion`(`idd`, `orig`, `dest`, `esta`, `llav`, `usua`)
     VALUES (NEW.id, NEW.estado, NEW.estado, 1, '',  NEW.usua);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_007_Documento_Dependencia`
--

CREATE TABLE `WKF_007_Documento_Dependencia` (
  `id` int NOT NULL,
  `wfd` int DEFAULT NULL COMMENT 'Documento Id WorkFlow',
  `nomb` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre de la unidad o dependencia'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_007_Documento_Detalle`
--

CREATE TABLE `WKF_007_Documento_Detalle` (
  `id` int NOT NULL,
  `wfd` int DEFAULT NULL COMMENT 'Documento Id WorkFlow',
  `numc` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Numero de Control',
  `fcre` timestamp NOT NULL COMMENT 'Fecha de Registro',
  `fori` timestamp NOT NULL COMMENT 'Fecha de Origen',
  `nori` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT ' Numero de Origen',
  `saso` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Salida Asociada',
  `tdoc` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Tipo de Documento',
  `remi` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Remitente',
  `udep` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Unidad o Dependencia',
  `coma` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Gran Comando',
  `cont` text CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Contenido',
  `inst` text CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Instrucciones',
  `carc` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Codigo de Archivo',
  `nexp` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Numero de Expediente',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre de Archivo',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `priv` int DEFAULT NULL COMMENT 'Privacidad',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `clas` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci COMMENT='Detalles del documento en general';

--
-- Disparadores `WKF_007_Documento_Detalle`
--
DELIMITER $$
CREATE TRIGGER `actualizarDocumentoDetalles` AFTER UPDATE ON `WKF_007_Documento_Detalle` FOR EACH ROW BEGIN
    INSERT INTO `WKF_007_Historico_Documento`
      (wfd, numc, fcre, fori, nori, saso, tdoc, remi, udep, coma, cont, 
      inst, carc, nexp, anom, usua, fech, tipo, priv) 
    VALUES 
      (OLD.wfd, OLD.numc, OLD.fcre, OLD.fori, OLD.nori, OLD.saso, OLD.tdoc, OLD.remi, OLD.udep, OLD.coma, OLD.cont, 
      OLD.inst, OLD.carc, OLD.nexp, OLD.anom, OLD.usua, OLD.fech, 1, OLD.priv);

    IF OLD.anom != '' THEN
      INSERT INTO `WKF_013_Documentos_Adjuntos`(`idd`, `nomb`, `usua`) 
      VALUES (OLD.wfd, OLD.anom, OLD.usua);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminarDocumentoDetalles` AFTER DELETE ON `WKF_007_Documento_Detalle` FOR EACH ROW BEGIN
      INSERT INTO `WKF_007_Historico_Documento`
        ( wfd, numc, fcre, fori, nori, saso, tdoc, remi, udep, cont, 
        inst, carc, nexp, anom, usua, fech, tipo, priv, coma) 
      VALUES 
        ( OLD.wfd, OLD.numc, OLD.fcre, OLD.fori, OLD.nori, OLD.saso, OLD.tdoc, OLD.remi, OLD.udep, OLD.cont, 
        OLD.inst, OLD.carc, OLD.nexp, OLD.anom, OLD.usua, OLD.fech,9, OLD.priv, OLD.coma);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_007_Documento_PuntoCuenta`
--

CREATE TABLE `WKF_007_Documento_PuntoCuenta` (
  `id` int NOT NULL,
  `wfd` int DEFAULT NULL COMMENT 'Documento Id WorkFlow',
  `cuen` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Punto de Cuenta',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Detalles del punto',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `esta` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_007_Historico_Documento`
--

CREATE TABLE `WKF_007_Historico_Documento` (
  `id` int NOT NULL,
  `wfd` int DEFAULT NULL COMMENT 'Documento Id WorkFlow',
  `numc` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Numero de Control',
  `fcre` timestamp NOT NULL COMMENT 'Fecha de Registro',
  `fori` timestamp NOT NULL COMMENT 'Fecha de Origen',
  `nori` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT ' Numero de Origen',
  `saso` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Salida Asociada',
  `tdoc` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Tipo de Documento',
  `remi` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Remitente',
  `udep` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Unidad o Dependencia',
  `coma` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Gran Comando',
  `cont` text CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Contenido',
  `inst` text CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Instrucciones',
  `carc` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Codigo de Archivo',
  `nexp` varchar(32) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Numero de Expediente',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre de Archivo',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `priv` int DEFAULT NULL COMMENT 'Privacidad',
  `tipo` int NOT NULL COMMENT 'Tipo de Documento Papelera o historico',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_008_Documento_Nota`
--

CREATE TABLE `WKF_008_Documento_Nota` (
  `id` int NOT NULL COMMENT 'Identificador',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre del archivo',
  `llav` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Llave',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_008_Documento_Ubicacion`
--

CREATE TABLE `WKF_008_Documento_Ubicacion` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idd` int NOT NULL COMMENT 'Id Documento',
  `orig` int NOT NULL COMMENT 'Origen del Documento',
  `dest` int NOT NULL COMMENT 'Estado del documento de destino',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `llav` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Llave',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Disparadores `WKF_008_Documento_Ubicacion`
--
DELIMITER $$
CREATE TRIGGER `actualizarUbicacion` BEFORE UPDATE ON `WKF_008_Documento_Ubicacion` FOR EACH ROW BEGIN
  IF NEW.dest = 1 THEN
    UPDATE `WKF_006_Documento` SET  obse='RECHAZADO',  estado=1, usua=NEW.usua, estatus=1 WHERE id=OLD.idd;
  ELSEIF NEW.llav != OLD.llav THEN
    UPDATE `WKF_006_Documento` SET obse='POR NOTA ENTREGA', estado=OLD.dest, usua=NEW.usua, estatus=NEW.esta WHERE id=OLD.idd;
    END IF;
   
  IF NEW.dest = (SELECT id FROM WKF_003_Estado WHERE nomb='Papelera') THEN
    UPDATE `WKF_006_Documento` SET obse='ENVIADO A PAPELERA', estado=(SELECT id FROM WKF_003_Estado WHERE nomb='Papelera'), usua=NEW.usua, estatus=1 WHERE id=OLD.idd;
  ELSE
    UPDATE `WKF_006_Documento` SET  obse='PROMOVIDO', estado=NEW.orig, usua=NEW.usua, estatus=NEW.esta WHERE id=OLD.idd;
  END IF ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_009_Documento_Variante`
--

CREATE TABLE `WKF_009_Documento_Variante` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idd` int NOT NULL COMMENT 'Id Documento',
  `acci` int NOT NULL COMMENT 'Accion del  Documento',
  `obse` text CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Contenido',
  `estado` tinyint(1) NOT NULL COMMENT 'Estado',
  `estatus` tinyint(1) NOT NULL COMMENT 'Estatus',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_010_Estatus`
--

CREATE TABLE `WKF_010_Estatus` (
  `id` int NOT NULL,
  `ide` int NOT NULL COMMENT 'Estado',
  `idc` int NOT NULL COMMENT 'Codigo',
  `nomb` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_011_Alerta`
--

CREATE TABLE `WKF_011_Alerta` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idd` int NOT NULL COMMENT 'Id Documento',
  `ide` int NOT NULL COMMENT 'Identificador del estado',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `acti` tinyint(1) NOT NULL COMMENT 'Activo',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Actualizacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Disparadores `WKF_011_Alerta`
--
DELIMITER $$
CREATE TRIGGER `actualizarAlerta` AFTER UPDATE ON `WKF_011_Alerta` FOR EACH ROW BEGIN
  INSERT INTO `WKF_011_Alerta_Historico`
  (`idd`, `ide`, `esta`, `acti`, `fech`, `usua`, `obse`, `update`) 
  VALUES 
  (OLD.idd,OLD.ide,OLD.esta,OLD.acti,OLD.fech,OLD.usua,OLD.obse,OLD.update);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_011_Alerta_Historico`
--

CREATE TABLE `WKF_011_Alerta_Historico` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idd` int NOT NULL COMMENT 'Id Documento',
  `ide` int NOT NULL COMMENT 'Identificador del estado',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `acti` tinyint(1) NOT NULL COMMENT 'Activo',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Actualizacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_012_Traza`
--

CREATE TABLE `WKF_012_Traza` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idd` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Id Documento',
  `ide` int NOT NULL COMMENT 'Identificador del estado',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_013_Documentos_Adjuntos`
--

CREATE TABLE `WKF_013_Documentos_Adjuntos` (
  `id` int NOT NULL COMMENT 'Identificador',
  `idd` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Id Documento',
  `nomb` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre del Archivo',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_014_Campos_Dinamicos`
--

CREATE TABLE `WKF_014_Campos_Dinamicos` (
  `id` int NOT NULL,
  `nomb` varchar(64) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Nombre',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Descripcion',
  `clase` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Clasificacion',
  `form` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Formato del campo',
  `fnx` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Funcion de la API',
  `esta` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Estatus del campo',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_015_SubDocumento`
--

CREATE TABLE `WKF_015_SubDocumento` (
  `id` int NOT NULL,
  `idd` int DEFAULT NULL COMMENT 'Documento Id WorkFlow',
  `ide` int NOT NULL COMMENT 'Estado del documento de destino',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `resu` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Resumen',
  `deta` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Detalle',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Nombre de Archivo',
  `cedu` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Cedula',
  `carg` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Cargo',
  `nomm` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Nombre Militar',
  `priv` int DEFAULT NULL COMMENT 'Privacidad',
  `fcre` timestamp NOT NULL COMMENT 'Fecha de Registro',
  `cuen` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Cuenta Asociada',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `acti` int NOT NULL COMMENT 'ACtividad del Documento',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Disparadores `WKF_015_SubDocumento`
--
DELIMITER $$
CREATE TRIGGER `actualizarSubDocumento` AFTER UPDATE ON `WKF_015_SubDocumento` FOR EACH ROW BEGIN
  INSERT INTO 
    `WKF_015_SubDocumento_Historico`(`idd`, `ide`, `esta`, `resu`, `deta`, `anom`, `cedu`, `carg`, `nomm`, `priv`, `fcre`, `cuen`, `usua`, `acti`) 
  VALUES 
    ( OLD.idd, OLD.ide, OLD.esta, OLD.resu, OLD.deta, OLD.anom, OLD.cedu, OLD.carg, OLD.nomm, OLD.priv, OLD.fcre, OLD.cuen, OLD.usua, OLD.acti );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_015_SubDocumento_Alerta`
--

CREATE TABLE `WKF_015_SubDocumento_Alerta` (
  `id` int NOT NULL COMMENT 'Identificador',
  `ids` int NOT NULL COMMENT 'SubDocumento Id',
  `ide` int NOT NULL COMMENT 'Identificador del estado',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `acti` tinyint(1) NOT NULL COMMENT 'Activo',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Actualizacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Disparadores `WKF_015_SubDocumento_Alerta`
--
DELIMITER $$
CREATE TRIGGER `actualizarSubDocumentoAlerta` AFTER UPDATE ON `WKF_015_SubDocumento_Alerta` FOR EACH ROW BEGIN
  INSERT INTO `WKF_015_SubDocumento_Alerta_Historico`
  (`ids`, `ide`, `esta`, `acti`, `fech`, `usua`, `obse`, `update`) 
  VALUES 
  (OLD.ids,OLD.ide,OLD.esta,OLD.acti,OLD.fech,OLD.usua,OLD.obse,OLD.update);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_015_SubDocumento_Alerta_Historico`
--

CREATE TABLE `WKF_015_SubDocumento_Alerta_Historico` (
  `id` int NOT NULL COMMENT 'Identificador',
  `ids` int NOT NULL COMMENT 'SubDocumento Id',
  `ide` int NOT NULL COMMENT 'Identificador del estado',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `acti` tinyint(1) NOT NULL COMMENT 'Activo',
  `fech` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `obse` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Observaciones',
  `update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Actualizacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_015_SubDocumento_Historico`
--

CREATE TABLE `WKF_015_SubDocumento_Historico` (
  `id` int NOT NULL,
  `idd` int DEFAULT NULL COMMENT 'Documento Id WorkFlow',
  `ide` int NOT NULL COMMENT 'Estado del documento de destino',
  `esta` tinyint(1) NOT NULL COMMENT 'Estatus',
  `resu` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Resumen',
  `deta` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Detalle',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Nombre de Archivo',
  `cedu` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Cedula',
  `carg` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Cargo',
  `nomm` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Nombre Militar',
  `priv` int DEFAULT NULL COMMENT 'Privacidad',
  `fcre` timestamp NOT NULL COMMENT 'Fecha de Registro',
  `cuen` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Cuenta Asociada',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `acti` int NOT NULL COMMENT 'ACtividad del Documento'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_015_SubDocumento_Traza`
--

CREATE TABLE `WKF_015_SubDocumento_Traza` (
  `id` int NOT NULL,
  `ids` int DEFAULT NULL COMMENT 'SubDocumento Id WorkFlow',
  `esta` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Estatus',
  `acci` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Accion',
  `hist` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Historico',
  `come` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Comentario',
  `arch` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Archivo',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Nombre de Archivo',
  `deci` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Decision',
  `fcre` timestamp NOT NULL COMMENT 'Fecha de Registro',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `upda` timestamp NOT NULL COMMENT 'Actualizacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WKF_015_SubDocumento_Variante`
--

CREATE TABLE `WKF_015_SubDocumento_Variante` (
  `id` int NOT NULL,
  `ids` int DEFAULT NULL COMMENT 'SubDocumento Id WorkFlow',
  `esta` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Estatus',
  `acci` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Accion',
  `cuen` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'cuenta',
  `hist` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Historico',
  `come` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Comentario',
  `arch` text CHARACTER SET utf32 COLLATE utf32_spanish_ci COMMENT 'Archivo',
  `anom` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Nombre de Archivo',
  `deci` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL COMMENT 'Decision',
  `fcre` timestamp NOT NULL COMMENT 'Fecha de Registro',
  `usua` varchar(256) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL COMMENT 'Usuario Responsable',
  `upda` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Actualizacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Disparadores `WKF_015_SubDocumento_Variante`
--
DELIMITER $$
CREATE TRIGGER `actualizarSubDocumentoVariante` AFTER UPDATE ON `WKF_015_SubDocumento_Variante` FOR EACH ROW BEGIN
 INSERT INTO `WKF_015_SubDocumento_Traza`(`ids`, `esta`, `acci`, `hist`, `come`, `arch`, `anom`,`deci`, `fcre`, `usua`, `upda`)
  VALUES
 (OLD.ids,OLD.esta,OLD.acci,OLD.hist,come,OLD.arch,OLD.anom,OLD.deci,OLD.fcre,OLD.usua,OLD.upda);
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `WKF_001_Definicion`
--
ALTER TABLE `WKF_001_Definicion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_002_Serie`
--
ALTER TABLE `WKF_002_Serie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_003_Estado`
--
ALTER TABLE `WKF_003_Estado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_004_Transiciones`
--
ALTER TABLE `WKF_004_Transiciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_005_Red`
--
ALTER TABLE `WKF_005_Red`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `idw` (`idw`);

--
-- Indices de la tabla `WKF_006_Documento`
--
ALTER TABLE `WKF_006_Documento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `estado` (`estado`);

--
-- Indices de la tabla `WKF_007_Documento_Dependencia`
--
ALTER TABLE `WKF_007_Documento_Dependencia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`wfd`,`nomb`);

--
-- Indices de la tabla `WKF_007_Documento_Detalle`
--
ALTER TABLE `WKF_007_Documento_Detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `numc` (`numc`);

--
-- Indices de la tabla `WKF_007_Documento_PuntoCuenta`
--
ALTER TABLE `WKF_007_Documento_PuntoCuenta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`wfd`,`cuen`);

--
-- Indices de la tabla `WKF_007_Historico_Documento`
--
ALTER TABLE `WKF_007_Historico_Documento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `numc` (`numc`);

--
-- Indices de la tabla `WKF_008_Documento_Nota`
--
ALTER TABLE `WKF_008_Documento_Nota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `llav` (`llav`);

--
-- Indices de la tabla `WKF_008_Documento_Ubicacion`
--
ALTER TABLE `WKF_008_Documento_Ubicacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `idd` (`idd`);

--
-- Indices de la tabla `WKF_009_Documento_Variante`
--
ALTER TABLE `WKF_009_Documento_Variante`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_010_Estatus`
--
ALTER TABLE `WKF_010_Estatus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_011_Alerta`
--
ALTER TABLE `WKF_011_Alerta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idd` (`idd`,`ide`,`esta`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_011_Alerta_Historico`
--
ALTER TABLE `WKF_011_Alerta_Historico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `WKF_012_Traza`
--
ALTER TABLE `WKF_012_Traza`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `idd` (`idd`);

--
-- Indices de la tabla `WKF_013_Documentos_Adjuntos`
--
ALTER TABLE `WKF_013_Documentos_Adjuntos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `idd` (`idd`);

--
-- Indices de la tabla `WKF_014_Campos_Dinamicos`
--
ALTER TABLE `WKF_014_Campos_Dinamicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `fnx` (`fnx`);

--
-- Indices de la tabla `WKF_015_SubDocumento`
--
ALTER TABLE `WKF_015_SubDocumento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `idd` (`idd`);

--
-- Indices de la tabla `WKF_015_SubDocumento_Alerta`
--
ALTER TABLE `WKF_015_SubDocumento_Alerta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ids` (`ids`,`ide`,`esta`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_015_SubDocumento_Alerta_Historico`
--
ALTER TABLE `WKF_015_SubDocumento_Alerta_Historico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `WKF_015_SubDocumento_Historico`
--
ALTER TABLE `WKF_015_SubDocumento_Historico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idd` (`idd`);

--
-- Indices de la tabla `WKF_015_SubDocumento_Traza`
--
ALTER TABLE `WKF_015_SubDocumento_Traza`
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `WKF_015_SubDocumento_Variante`
--
ALTER TABLE `WKF_015_SubDocumento_Variante`
  ADD UNIQUE KEY `ids` (`ids`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `WKF_001_Definicion`
--
ALTER TABLE `WKF_001_Definicion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `WKF_002_Serie`
--
ALTER TABLE `WKF_002_Serie`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `WKF_003_Estado`
--
ALTER TABLE `WKF_003_Estado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_004_Transiciones`
--
ALTER TABLE `WKF_004_Transiciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_005_Red`
--
ALTER TABLE `WKF_005_Red`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_006_Documento`
--
ALTER TABLE `WKF_006_Documento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_007_Documento_Dependencia`
--
ALTER TABLE `WKF_007_Documento_Dependencia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_007_Documento_Detalle`
--
ALTER TABLE `WKF_007_Documento_Detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_007_Documento_PuntoCuenta`
--
ALTER TABLE `WKF_007_Documento_PuntoCuenta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_007_Historico_Documento`
--
ALTER TABLE `WKF_007_Historico_Documento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_008_Documento_Nota`
--
ALTER TABLE `WKF_008_Documento_Nota`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_008_Documento_Ubicacion`
--
ALTER TABLE `WKF_008_Documento_Ubicacion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_009_Documento_Variante`
--
ALTER TABLE `WKF_009_Documento_Variante`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_010_Estatus`
--
ALTER TABLE `WKF_010_Estatus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_011_Alerta`
--
ALTER TABLE `WKF_011_Alerta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_011_Alerta_Historico`
--
ALTER TABLE `WKF_011_Alerta_Historico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_012_Traza`
--
ALTER TABLE `WKF_012_Traza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_013_Documentos_Adjuntos`
--
ALTER TABLE `WKF_013_Documentos_Adjuntos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_014_Campos_Dinamicos`
--
ALTER TABLE `WKF_014_Campos_Dinamicos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_015_SubDocumento`
--
ALTER TABLE `WKF_015_SubDocumento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_015_SubDocumento_Alerta`
--
ALTER TABLE `WKF_015_SubDocumento_Alerta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_015_SubDocumento_Alerta_Historico`
--
ALTER TABLE `WKF_015_SubDocumento_Alerta_Historico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador';

--
-- AUTO_INCREMENT de la tabla `WKF_015_SubDocumento_Historico`
--
ALTER TABLE `WKF_015_SubDocumento_Historico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_015_SubDocumento_Traza`
--
ALTER TABLE `WKF_015_SubDocumento_Traza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `WKF_015_SubDocumento_Variante`
--
ALTER TABLE `WKF_015_SubDocumento_Variante`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
