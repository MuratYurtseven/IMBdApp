//
//  MainViewController.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var gotList = [Movie]()
    var isSearching:Bool = false
    var arananKelime = ""
    
    var timer:Timer?
    var shouldFetchData:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        //DegisnOfCollection
        
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width
        
        design.sectionInset = UIEdgeInsets(top: 4, left: 1.5, bottom: 4, right: 1.5)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        let cellWidth = (width-16)/2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.45)
        collectionView!.collectionViewLayout = design}
        
        
        override func viewWillAppear(_ animated: Bool) {
            if arananKelime != ""{
                getMovie(searchedMovie: arananKelime)}
            else{
                getMovie(searchedMovie: "Spider-Man")
            }
            
        }
      
        func getMovie(searchedMovie:String){
            
            let headers: HTTPHeaders = ["content-type":"application/json","authorization":"apikey 6WHJk9djzrq85r3YgEeqX5:0ObsI1Fq3zveaOGaKOkZuH"]
            let url = "https://api.collectapi.com/imdb/imdbSearchByName"
            
            let params : Parameters = ["query":searchedMovie]
            
            AF.request(url,method: .get,parameters: params,headers: headers).validate().responseDecodable(of: MovieResponse.self){ response in
                
                switch response.result{
                case .success(let cevap):
                    if let results = cevap.result {
                        self.gotList = results.filter { $0.Type == "movie" }
                        //filter is used to create a new array (self.gotList) that only includes items where the Type is "movie".
                        print(self.gotList)
                    }
                case .failure(let error):
                    print("Error \(error.localizedDescription)")}
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.collectionView.reloadData()
                }}
            
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail"{
                let indeks = sender as! Int
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.imbdID = gotList[indeks].imdbID
                
            }
        }
        
    }
    
extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource{
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return gotList.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! movieCollectionViewCell
            cell.movieTitleLabel.text = gotList[indexPath.row].Title
            
            if let url = URL(string: gotList[indexPath.row].Poster!){
                if gotList[indexPath.row].Poster == "N/A" {
                    cell.movieImageView.image = UIImage(named: "No_Image_Available")
                }
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url){
                        
                        DispatchQueue.main.async {
                            cell.movieImageView.image = UIImage(data: data)
                        }}
                    else{
                        print("Error loading image data from URL: \(url)")
                    }
                }
                
            }
            
            cell.layer.borderColor = UIColor.orange.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 16
            cell.clipsToBounds = true
            
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toDetail", sender: indexPath.row)
        }
        
    }
    
    
    
extension MainViewController : UISearchBarDelegate{
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
                arananKelime = ""
                isSearching = false
            }
            else{
                arananKelime = searchText
                isSearching = true
                getMovie(searchedMovie: searchText)
                
            }
        }
    }

