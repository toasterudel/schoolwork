def main():
    with open("input.txt", 'r') as textFile:
        plaintext = textFile.read()
        
    plaintext = plaintext.replace(',',' ')
    lines = [line.split() for line in plaintext]
    
    h = "hello "
    w = "world"
    print(h + w)
main()
