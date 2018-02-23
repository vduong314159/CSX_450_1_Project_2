install_load_pkg <- function(pkg) {
    is_pkg_installed <- require(pkg, character.only=FALSE, quietly=T)
    if (!is_pkg_installed) {
        cat("installing pkg")
        install.packages(pkg, character.only = FALSE)
    }
    else {
        cat("Pkg already installed \n")
    }
        cat("loadg pkg ie running library(package_name)")
        library(pkg, character.only=FALSE)
}