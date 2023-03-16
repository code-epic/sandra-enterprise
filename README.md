<p align="center">
<img align="center" src="https://raw.githubusercontent.com/code-epic/sandra-enterprise/fc4db4d7542fb937d20a06086c37ebf6d527fcde/img/logo.svg" width=" 200px;"/>
</p>

**Sandra Server Enterprise** es una plataforma para arquitecturas empresariales que estará operativa para su organización ampliando la relación entre sistemas de diferentes naturaleza, así como la colaboración entre sus tecnologías adyacentes que nunca fueron tan importantes como lo son hoy en día, también cuenta con capacidades comunes compartidas para todos los productos, como el registro integrado, la gestión de usuarios, el transportes de información, **la seguridad,** los registro persistentes, la agrupación de servicios y respaldo, la generación de su propio caché, la coordinación y un marco de interfaz gráfica de usuario donde podrá gestionar toda las actividades de administración.

Cuando hablamos de Sandra Server hacemos referencia a un término genérico, que incluye desde **herramientas de integración** hasta gestión de contenidos y documentos, pasando por portales web, gestión de procesos de negocio o servidores de aplicaciones. Establecer comunicación efectiva y ágil entre las bases de datos y las aplicaciones que utiliza el usuario al final del proceso, ya se trate de un Enterprise Resource Planning (ERP) o de un Customer Relationship Management (CRM).

Ahora bien permite extender a múltiples conexiones y avanzar con lo nuevos desarrollos en aprendizaje automatizado conocido como Machine Learning (ML) que deje a su organización ir avanzando en las diferentes áreas tecnológicas, alcanzando el monitoreo de sistemas, instalación de aplicaciones, creación de código Back-End, haciendo uso de la herramientas de alertas tempranas podrá evitar fallos de toda su red mientras va generando nuevas políticas que automaticen sus procesos internos.

El crecimiento y las nuevas tecnologías siempre nos hablan de la importancia de ir avanzando evitando estar obsoleto y con Sandra Server podrá ir escalando en esos grandes cambios que suceden a diario.

Desde el enfoque de la seguridad ofrece canalizar los diferentes accesos entre los sistemas brindando un mayor control y monitoreo sobre la red y los sistemas
  

## Alcance

Es una herramienta capaz de integrar programadores, técnicos e ingenieros en la creación de software, abarcando los diferentes ambientes que existen en el ciclo del desarrollo de los sistemas.

## Funcionalidad

Sandra Server conecta distintas arquitecturas de aplicaciones permitiendo compatibilizar esas estructuras, así logra ofrecer métodos en los diferentes ámbitos de conexión como son los entornos de: desarrollo, calidad y producción implantado un nuevo escenario para pruebas de integridad transfiriendo datos de una aplicación a otra del mismo modo entre archivos y/o base de datos.

La plataforma es un software que se conecta a otros sistemas y protocolos lo que sirve para:

-   Diseñar una red desarticulada y distribuida.
-   Generar homogeneidad en un conjunto de aplicaciones.
-   Proporciona una interfaz uniforme a los desarrolladores.
-   Ofrecer un grupo de servicios genéricos que permite que las aplicaciones funcionen conjuntamente y evita que los sistemas dupliquen esfuerzos.
    
Asimismo, contribuye al desarrollo de aplicaciones proporcionando habituales abstracciones de programación, enmascarando la heterogeneidad de aplicaciones y la distribución de hardware y sistemas operativos subyacentes, ocultando la información de programación de bajo nivel. Ayuda a los desarrolladores, los arquitectos y los líderes empresariales a automatizar las decisiones manuales, lo cual mejora la gestión de los recursos y el nivel de eficiencia general. Los desarrolladores y los arquitectos pueden trabajar con agilidad en diferentes niveles teniendo como referencia conjuntos de lenguajes de programación, marcos y tiempos de ejecución básicos. También ofrece las funciones que se utilizan con más frecuencia, como los servidores web, el inicio de sesión

## Instalación

Sandra Server Enterprise, versiones bajo linux: Fedora 30+, CentOS 7+, Redhat

## Dependencias
Asegurese de tener instalado las siguientes dependencias:

* `python` 3 or superior
* `git`
* C compiler (cross-compiling necesita compilar algunas veces)
* `curl` 
* `pkg-config` 
* `libiconv` 
* OpenSSL (`libssl-dev` or `openssl-devel` depende de la version linux).
* `libstdc++-static` 

## Requerimientos
* [MongoDB 4+](https://www.mongodb.com/docs/manual/administration/install-enterprise-linux/)
* MysqlServer 8+
* [Golang 1.9+](https://go.dev/doc/install)


```sh 
# Instalacion desde script como root
# @author crash.madover@gmail.com
curl -L https://github.com/code-epic/sandra-enterprise/raw/main/pkg/linux/x86_64/sandra_cli.zip -o sandra_cli.zip
unzip sandra_cli.zip
rm -rf sandra_cli.zip
chmod +x sandra_cli
sudo ./sandra_cli install --option service 
```


***

## Preparando - Base de Datos
