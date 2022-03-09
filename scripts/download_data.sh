#!/bin/bash
# Download DLPFC data
## Download all preprocessed DLPFC slices
for fn in 151507 151508 151509 151510 151669 151670 151671 151672 151673 151674 151675 151676; do
    wget -O ../data/DLPFC/${fn}_preprocessed.h5 https://zenodo.org/record/6334774/files/${fn}_preprocessed.h5?download=1
done

## Download DLPFC slice metadata
wget -O ../data/DLPFC/spatialLIBD_table_S5.csv https://zenodo.org/record/6334774/files/spatialLIBD_table_S5.csv?download=1

## Download raw sample III, slice 151674 for visualization-dlpfc.ipynb
download_slice_files() {
    wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/LieberInstitute/HumanPilot/master/10X/$1/scalefactors_json.json -P sample-$2/$1/spatial
    wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/LieberInstitute/HumanPilot/master/10X/$1/tissue_hires_image.png -P sample-$2/$1/spatial
    wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/LieberInstitute/HumanPilot/master/10X/$1/tissue_lowres_image.png -P sample-$2/$1/spatial
    wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/LieberInstitute/HumanPilot/master/10X/$1/tissue_positions_list.txt -P sample-$2/$1/spatial
    wget https://spatial-dlpfc.s3.us-east-2.amazonaws.com/h5/$1_filtered_feature_bc_matrix.h5 -P sample-$2/$1
}
rm -rf ../data/DLPFC/sample-3
download_slice_files 151674 3
mv sample-3 ../data/DLPFC/
cd ../data/DLPFC/sample-3/151674/spatial
mv tissue_positions_list.txt tissue_positions_list.csv

# Download Stahl BC data
wget -O ../data/Stahl-BC/stahl_bc_data.zip https://zenodo.org/record/6334774/files/stahl_bc_data.zip?download=1
## and unzip it
unzip -d ../data/Stahl-BC/ ../data/Stahl-BC/stahl_bc_data.zip