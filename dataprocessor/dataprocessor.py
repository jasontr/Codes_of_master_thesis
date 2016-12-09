#coding:utf-8
import os, regprocessor
def dataprocessor(input_path):
	File_list = []
	if input_path == "":
		#rootpath = '../Tensor_completion/data_r3/'
		#rootpath = 'C:\Users\jason_000\Documents\coding\Codes_of_master_thesis\Tensor_completion\data_r3'
		rootpath = '..\Tensor_completion\data_beta'
	else:
		rootpath = input_path
	for root, subfolders, files in os.walk(rootpath):
		if 'done' in subfolders:
			subfolders.remove('done')

		for f in files:
			if f.find('.txt') != -1:
				File_list.append(os.path.join(root, f))

	for item in File_list:
		regprocessor.regprocessor(item)
