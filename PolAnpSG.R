library(terra)
library(dplyr)
library(sf)
library(ggplot2)

shp_path <- "c:/GitHub/PlantNativeSG/anpest20gw/anpest20gw.shp"

pol <- sf::st_read(shp_path)

# Filtrar por los nombres que te interesan
subpol <- pol %>%
  filter(NOMBRE %in% c("Sierra de Guadalupe", "La Armella"))

# Unir los polígonos seleccionados en uno solo
union_pol <- st_union(subpol)
# Plot the result to see the dissolved polygon
plot(union_pol, main = "Dissolved Polygon with st_union")
#Save the polygon
sf::st_write(union_pol, "SDGpolygon.shp")
# Create the plot
ggplot() +
  # Plot the original individual polygons with transparency
  geom_sf(data = subpol, aes(fill = NOMBRE), alpha = 0.5, color = "black") +
  # Plot the union polygon as an outline
  geom_sf(data = union_pol, fill = NA, color = "red", linewidth = 1.5) +
  # Colors and labels
  scale_fill_manual(values = c("Sierra de Guadalupe" = "lightblue", 
                               "La Armella" = "lightgreen")) +
  labs(title = "Polygons: Sierra de Guadalupe and La Armella",
       subtitle = "Colored areas: Original polygons | Red outline: Union",
       fill = "Polygon Name") +
  theme_minimal()

###


#SDname <- "Sierra de Guadalupe"
#Armella <- "La Armella"

#pol$NOMBRE