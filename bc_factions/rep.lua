
txd = engineLoadTXD("crown.txd")
engineImportTXD(txd, 598)
dff = engineLoadDFF("crown.dff")
engineReplaceModel(dff, 598)