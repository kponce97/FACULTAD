JAVA_HOME=/c/Program\ Files/Eclipse\ Adoptium/jdk-17

run:
	JAVA_HOME=$(JAVA_HOME) \
	PATH="$(JAVA_HOME)/bin:$$PATH" \
	SBT_OPTS="--add-exports=java.base/sun.nio.ch=ALL-UNNAMED" \
	sbt run

compile:
	JAVA_HOME=$(JAVA_HOME) \
	PATH="$(JAVA_HOME)/bin:$$PATH" \
	sbt compile

clean:
	sbt clean