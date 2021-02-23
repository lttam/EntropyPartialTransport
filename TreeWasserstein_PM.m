function dd = TreeWasserstein_PM(XX, WX, ZZ, WZ, TM)

hX = TreeMapping_Id2V(XX, WX, TM);
hZ = TreeMapping_Id2V(ZZ, WZ, TM);

dd = sum(abs(hX - hZ));

end



