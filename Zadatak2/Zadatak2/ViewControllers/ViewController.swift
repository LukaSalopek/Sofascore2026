//
//  ViewController.swift
//  Zadatak2
//
//  Created by akademija on 10.03.2026..
//

import UIKit
import SofaAcademic
import SnapKit


class ViewController: UIViewController {
    
    private var leagueView=LeagueView()
    let data = Homework2DataSource()
    
    lazy var matches = data.laLigaEvents()
    lazy var league = data.laLigaLeague()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeague()
        setupMatchViews()
        
    }
    
    
    func setupLeague(){
        view.addSubview(leagueView)
        leagueView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        var leagueName=downloadImage(from: league.logoUrl!)
        leagueView.configure(leagueLogo: leagueName, countryName: league.country!.name, leagueName: league.name)
    }
    
    func setupMatchViews(){
        
        var matchView=MatchView()
        matchView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(20)
        }
        
    }
    
        func downloadImage(from urlString: String) async -> UIImage? {
            guard let url = URL(string: urlString) else { return nil }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return UIImage(data: data)
            } catch {
                print("Greška pri preuzimanju: \(error)")
                return nil
            }
        }
    


}



#Preview{
    ViewController()
}

