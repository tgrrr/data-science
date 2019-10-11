#'Contains all constants used in this project
#'@author Shadi Samir

#---- data.segments ----
stack.list <- c("data.stack", "train.stack", "valid.stack")

#---- data.segments ----
segment.list <- c("data.segment", "train.segment", "valid.segment")

#---- forbidenModels ----
forbidenModels <- c("AMN", "AMA", "AMM", #E: A, T: M,     S: N.A.M
                    "ANM", "AAM",        #E: A, T: N.A.M, S: M
                    "MMA")               #E: M, T: M,     S: M

#---- forbidenDampeds ---- #if trend is N combination dont use damped = T
forbidenDampeds <- c("ANN", "MNN",
                     "ANA", "MNA",
                     "MMN", "MNM")

#---- Consts: category.list ----
category.list = c("MICRO", "DEMOGRAPHIC", "OTHER", "INDUSTRY", "MACRO", 
                  "FINANCE")

#---- Consts: yearly.n.list ----
yearly.n.list = c("20", "34", "43", "47", "45", "32", "44", "38", "46", "23",
                  "22", "41", "31", "24", "35", "30", "25", "27", "21", "26",
                  "40", "37", "36")

#---- Consts: monthly.n.list ----
monthly.n.list = c("68", "69", "126", "141", "144", "140", "128", "134", "133",
                   "142", "98", "122", "132", "120", "108", "107", "84", "143",
                   "104", "110", "115", "100", "81", "74", "83", "99", "86",
                   "89", "76", "94", "79", "78", "73", "114", "70", "135", "72",
                   "71", "96", "138")

#---- Consts: qrt.n.list ----
qrt.n.list = c("44", "45", "40", "43", "42", "46", "59", "64", "68", "32",
               "71", "72", "52", "48", "50", "24", "51", "49", "53", "35",
               "66", "47", "39", "67", "37", "70", "58", "56", "38", "57")

