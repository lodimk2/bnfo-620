# Code subsets a Uniprot species spreadsheet by comparing its similarity with eggnog ortholog families in ecoli


# Read in dataframes

ecoli_df <- read.csv("uniprot-proteome_UP000000558.tab", sep = "\t")
vulgatus_df <- read.csv("vulgatus_tab.tab", sep = "\t")
library(stringr)


# Write ecoli eggnog orthologs into a txt file
write(ecoli_df$Cross.reference..eggNOG., "ecoli_search.txt")

# Load in this text file as a table
search_start <- read.table("ecoli_search.txt")
# Remove semicolon from each string
search_start$V1 <- gsub(";", "", search_start$V1)

# Make each eggnog ortholog family an individual in a large regex searchstring
search_string <- (paste(search_start$V1, collapse = "|"))

# New dataframe is shared ortho families in ecoli from the orginal dataframe, (in example case vulgatus, could be anything)
new_df <- vulgatus_df[str_detect(vulgatus_df$Cross.reference..eggNOG., search_string),  ]

# Write csv to a new file
write.csv(new_df, "vulgatus_ecoli_orthos.csv")
