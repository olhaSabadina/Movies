//
//  SearchDataSourse.swift
//  Movies
//
//  Created by Olga Sabadina on 23.01.2024.
//

import Foundation

let mocHeaderDataDetail = MainSectionModel(titleName: "Loki", duration: 43, channelTitle: "14-TV", percentTitle: "34%", yearMovie: " (2023)", videoURLString: "https://www.w3schools.com/html/mov_bbb.mp4", genteType: ["Action & Adventure","Sci-Fi & Fantasy"], descriptionHeader: "After stealing the Tesseract during the events of “Avengers: Endgame,” an alternate version of Loki is brought to the mysterious Time Variance Authority.", percent: 74)

let mocActorsDataModel = SecondSectionModel(titleSection: "Series Cast", actord: [
    ActorModel(name: "Tom Hiddleston", photo: "pencil.circle.fill", filmName: "Loki", description: "Gugulethu Sophia Mbatha-Raw MBE is an English actress, known for her role as Kelly in Black Mirror, Dido Elizabeth Belle in Belle, Noni Jean in Beyond the Lights, and Plumette in Beauty and the Beast.", actorGender: "Actor"),
    ActorModel(name: "Owen Wilson", photo: "pencil.and.outline", filmName: "Mobius M. Mobius", description: "Gugulethu Sophia Mbatha-Raw MBE is an English actress, known for her role as Kelly in Black Mirror, Dido Elizabeth Belle in Belle, Noni Jean in Beyond the Lights, and Plumette in Beauty and the Beast.", actorGender: "Actor"),
    ActorModel(name: "Gugu Mbatha- Raw", photo: "https://lux.fm/uploads/media_news/2023/11/655cb33559d51370590931.jpg?w=640", filmName: "Ravonna Renslayer", description: "Gugulethu Sophia Mbatha-Raw MBE is an English actress, known for her role as Kelly in Black Mirror, Dido Elizabeth Belle in Belle, Noni Jean in Beyond the Lights, and Plumette in Beauty and the Beast.", actorGender: "Actress"),
    ActorModel(name: "Wunmi Mosaku", photo: "pencil.slash", filmName: "Hunter B-15", description: "Gugulethu Sophia Mbatha-Raw MBE is an English actress, known for her role as Kelly in Black Mirror, Dido Elizabeth Belle in Belle, Noni Jean in Beyond the Lights, and Plumette in Beauty and the Beast.", actorGender: "Actor"),
    
])

let dataForThirdSection = [
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Season 1", description: "2021 | 6 Episodes"),
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Season 1", description: "2021 | 6 Episodes"),
]

let mocForSocialSection = [
    SocialCellModel(text: "There are no discussions for Loki. Login to be first!")
]

let mocForMedia = [
    MediaModelCell(movieUrl: "https://www.w3schools.com/html/mov_bbb.mp4", moviePoster: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg"),
    MediaModelCell(movieUrl: "https://www.w3schools.com/html/mov_bbb.mp4" , moviePoster: "https://image.tmdb.org/t/p/original/qhb1qOilapbapxWQn9jtRCMwXJF.jpg?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"),
//    MediaModelCell(movieUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg")
]

let mocForRecomendationSection = [
MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Ragnarok", description: nil, percent: 67),
MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Jupiter's Legacy", description: nil, percent: 35),
MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Riverdale", description: nil, percent: 90)
]

let searchMain = [
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Orange", description: "A small Norwegian town experiencing warm winters and violent downpours seems to ..."),
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2313828801/display_1500/stock-photo-wooden-box-with-save-file-icon-or-download-file-format-jpeg-png-gif-pdf-svg-and-mp-file-file-2313828801.jpg", title: "Blue", description: "The minWidth property is used to set the minimum width of a given element. It prevents the used value of the width property from becoming smaller than the value specified for minWidth. The value of minWidth overrides both maxWidth and width. Defaults to ASDimensionAuto."),
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2375815857/display_1500/stock-photo-jpg-image-file-icon-file-type-icon-files-format-and-document-concept-d-render-illustration-2375815857.jpg", title: "Green", description: "The minWidth property is used to set the minimum width of a given element. It prevents the used value of the width property from becoming smaller than the value specified for minWidth. The value of minWidth overrides both maxWidth and width. Defaults to ASDimensionAuto. car"),
]

let searchSearch = [
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Loki", description: nil),
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2313828801/display_1500/stock-photo-wooden-box-with-save-file-icon-or-download-file-format-jpeg-png-gif-pdf-svg-and-mp-file-file-2313828801.jpg", title: "Mythical Detective Loki Ragnarok", description: nil),
    MovieCellModel(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2375815857/display_1500/stock-photo-jpg-image-file-icon-file-type-icon-files-format-and-document-concept-d-render-illustration-2375815857.jpg", title: "Thor & Loki - Blood Brothers", description: nil),
]

let mocForActingSection = [
    MovieCellModel(imageUrl: "https://img.freepik.com/free-photo/a-cat-is-sitting-in-a-movie-theater-and-eating-a-cup-of-popcorn_1340-32024.jpg?size=626&ext=jpg&ga=GA1.1.117140229.1705932620&semt=sph", title: "Come Away", asHeroInFilm: "as Adult Alice", yearEnterMovie: 2020),
    MovieCellModel(imageUrl: "https://img.freepik.com/free-photo/view-of-3d-cinema-elements_23-2150720822.jpg?size=626&ext=jpg&ga=GA1.1.117140229.1705932620&semt=sph", title: "Come Away", asHeroInFilm: "as Adult Alice", yearEnterMovie: 2020),
    MovieCellModel(imageUrl: "https://img.freepik.com/free-photo/vintage-collage-composition-design_23-2149485450.jpg?size=626&ext=jpg&ga=GA1.1.117140229.1705932620&semt=sph", title: "Misbehaviour", asHeroInFilm: "as Jennifer Hosten - Miss Grenada", yearEnterMovie: 2023),
    MovieCellModel(imageUrl: "https://img.freepik.com/free-photo/a-cat-is-sitting-in-a-movie-theater-and-eating-a-cup-of-popcorn_1340-32024.jpg?size=626&ext=jpg&ga=GA1.1.117140229.1705932620&semt=sph", title: "Come Away", asHeroInFilm: "as Adult Alice", yearEnterMovie: 2020),

]






/*
let searchMain = [
    Search(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Orange", description: "A small Norwegian town experiencing warm winters and violent downpours seems to ..."),
    Search(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2313828801/display_1500/stock-photo-wooden-box-with-save-file-icon-or-download-file-format-jpeg-png-gif-pdf-svg-and-mp-file-file-2313828801.jpg", title: "Blue", description: "The minWidth property is used to set the minimum width of a given element. It prevents the used value of the width property from becoming smaller than the value specified for minWidth. The value of minWidth overrides both maxWidth and width. Defaults to ASDimensionAuto."),
    Search(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2375815857/display_1500/stock-photo-jpg-image-file-icon-file-type-icon-files-format-and-document-concept-d-render-illustration-2375815857.jpg", title: "Green", description: "The minWidth property is used to set the minimum width of a given element. It prevents the used value of the width property from becoming smaller than the value specified for minWidth. The value of minWidth overrides both maxWidth and width. Defaults to ASDimensionAuto. car"),
]

let searchSearch = [
    Search(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2394491791/display_1500/stock-photo-welcome-the-new-year-with-a-realistic-gold-ribbon-on-a-black-background-explore-our-greeting-2394491791.jpg", title: "Loki", description: nil),
    Search(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2313828801/display_1500/stock-photo-wooden-box-with-save-file-icon-or-download-file-format-jpeg-png-gif-pdf-svg-and-mp-file-file-2313828801.jpg", title: "Mythical Detective Loki Ragnarok", description: nil),
    Search(imageUrl: "https://www.shutterstock.com/shutterstock/photos/2375815857/display_1500/stock-photo-jpg-image-file-icon-file-type-icon-files-format-and-document-concept-d-render-illustration-2375815857.jpg", title: "Thor & Loki - Blood Brothers", description: nil),
]
*/
