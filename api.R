#* Generate a histogram of random numbers
#* @png
#* @get /my_plot
function(){
    rand <- rnorm(100)
    hist(rand)
}
