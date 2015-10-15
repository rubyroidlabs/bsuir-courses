a=[" ____      _____","|  _ \    |__  /","| | | |     / / ","| |_| |    / /_ ","|____/    /____|"]
n=1
k=0
for j in 0..120
	for i in 0..k
		puts ""
	end
	if k>15
		n=-1
	end
	if k==0
		n=1
	end
	if n==1
		k=k+1
	end
	if n==-1
		k=k-1
	end
	for i in 0..4
		puts a[i]
	end
	if j>60
		for i in 0..4
			a[i][0]=''
		end
	end
	if j<60
		for i in 0..4
			a[i]=" "+a[i]
		end
	end
	sleep 0.1
	system("clear")
end