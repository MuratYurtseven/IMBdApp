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
        collectionView!.collectionViewLayout = design
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovie(searchedMovie: "Spider-Man")
    }
    
    
    func getMovie(searchedMovie:String){
        
        let headers: HTTPHeaders = ["content-type":"application/json","authorization":"apikey 6WHJk9djzrq85r3YgEeqX5:0ObsI1Fq3zveaOGaKOkZuH"]
        let url = "https://api.collectapi.com/imdb/imdbSearchByName"
        
        let params : Parameters = ["query":searchedMovie]
        
        AF.request(url,method: .get,parameters: params,headers: headers).validate().responseDecodable(of: MovieResponse.self){ response in
            
            switch response.result{
            case .success(let cevap):
                if let results = cevap.result{
                    self.gotList = results
                    print(self.gotList)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")}
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }}
        
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
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage(data: data!)
                }}}
        
        cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 16
        cell.clipsToBounds = true
        
        return cell
        
        }
    
}



extension MainViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
