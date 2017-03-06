::Run Burp from windows with Java SNI disabled for misconfigured web servers (do not forget to update location of JAR file).
java -Djsse.enableSNIExtension=false -jar C:\burpsuite.jar
