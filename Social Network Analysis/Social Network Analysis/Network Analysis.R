##learning/testing##
install.packages("igraph")
library(igraph)

# One direction Communication:
g <- graph(c(1, 2, 2, 3, 3, 4, 4, 1), directed=TRUE, n=7)
plot(g,
     vertex.color ="green",
     vertex.size= 40,
     edge.color ='red')

g[]

g1 <- graph(c("Sam", "Lin", "Lin", "Sun", "Sun", "Sam", "Justin", "Lin", "Sun", "Lin"), directed=TRUE)
plot(g1,
     vertex.color ="purple",
     vertex.size= 40,
     edge.color ='red')

g1

g2 <- graph(c("Sam", "Lin", "Lin", "Sun", "Sun", "Sam", "Justin", "Lin", "Lin", "Sun"), directed=FALSE)
plot(g2,
     vertex.color ='green',
     vertex.size= 40,
     edge.color ='red')


#Network Measures:
degree(g1, mode='all')
degree(g1, mode='in')
degree(g1, mode='out')

diameter(g1, directed=F)
diameter(g1, directed=F, weights=NA)
edge_density(g1, loops=F)

ecount(g1)/((vcount(g1)*(vcount(g1)-1)))

reciprocity(g1)
closeness(g1, mode='all', weights=NA)

betweenness(g1, directed=T, weights=NA)

#Reading datset:
install.packages("RCurl")
library(RCurl)

data <- read.csv(text=getURL("https://raw.githubusercontent.com/MoetezAbbassi/R-Data-Projects/refs/heads/main/Social%20Network%20Analysis/Social%20Network%20Analysis/networkdata.csv"), header=TRUE)
y<-data.frame(data$first, data$second)

#Creating a network:
net<-graph.data.frame(y, directed=T)
V(net)
E(net)
V(net)$label <- V(net)$name
V(net)$degree <- degree(net)

#Histogram of node tree:

hist(V(net)$degree,
     col='green',
     main= 'Histogram of Node Degree',
     ylab= 'Frequency',
     xlab= 'Degree of Vertices')
#Network diagram:
set.seed(222)
plot(net,
     vertex.color='green',
     vertext.size=2,
     vertex.label.dist=1.5,
     edge.arrow.size=0.1,
     vertex.label.cex=0.8)
