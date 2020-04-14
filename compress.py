import zlib
import sys
from time import clock

def my_compress(src,dst,level):
	print "Compressing %s to %s @level %s....." % (src,dst,level)
	fin = open(src,"rb")
	fout = open(dst,"wb")
	
	comobj = zlib.compressobj(int(level))
	data = fin.read(1024)
	loop = 0
	compress_cnt = 0;
	file_length = len(data);
	
	while data:
		cdata = comobj.compress(data)
		compress_cnt = compress_cnt + len(cdata)
		fout.write(cdata)
		data = fin.read(1024)
		file_length = file_length + len(data)
		loop = loop + 1
		if loop % 1024 == 0:
			print ".",
	
	fout.write(comobj.flush())
	print "\nCompress rate is %.2f"%(float(compress_cnt)/file_length)
	fin.close()
	fout.close()
	
def my_decompress(src,dst):
	print "Decompressing %s to %s" % (src,dst)
	fin = open(src,"rb")
	fout = open(dst,"wb")
	
	comobj = zlib.decompressobj()
	data = fin.read(1024)
	loop = 0
	
	while data:
		fout.write(comobj.decompress(data))
		data = fin.read(1024)
		loop = loop + 1
		if loop % 1024 == 0:
			print ".",
	
	fout.write(comobj.flush())
	fin.close()
	fout.close()

def usage():
	print "Usage: python compress.py [c|d] src dst level"
	
compress = "c"
decompress = "d"
	
if __name__ == "__main__":
	if cmp(sys.argv[1],compress) == 0: # do compressing
		if len(sys.argv) >= 5:
			start = clock()
			my_compress(sys.argv[2],sys.argv[3],sys.argv[4])
			end = clock()
			print "\nin %.2f seconds"%(end - start)
		else:
			print "arguemnts less than 5"
			usage()
	elif cmp(sys.argv[1],decompress) == 0: # do decompressing
		if len(sys.argv) >= 4:
			start = clock()
			my_decompress(sys.argv[2],sys.argv[3])
			end = clock()
			print "\nin %.2f seconds"%(end - start)			
		else:
			print "arguemnts less than 4"
			usage()
	else:
		print "argv[1] = %s" % sys.argv[1]
		usage()