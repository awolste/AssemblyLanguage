default: multiply.java
	javac multiply.java

run: multiply.class
	java multiply

clean:
	rm -f *.class